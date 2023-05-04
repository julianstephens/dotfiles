#!/usr/bin/env zx

const PNAME = argv._[0];
const IS_PRIVATE = Boolean(argv.p || argv.private);
const USE_AI = Boolean(argv.ai || argv.a);
const USE_EMOJI = Boolean(argv.emoji || argv.e);
const ERROR = chalk.bgRed("Error");

const DEV_DEPS = [
  "black",
  "pyright",
  "isort",
  "flake8",
  "pydocstyle",
  "mypy",
  "pre-commit",
];
const USAGE =
  "usage: cpy <project_name> [--private| -p][--emoji| -e][--ai| -a][--help| -h]";

const TEMP_DIR = `${os.homedir}/dotfiles/project-templates/python`;
const PROJ_DIR = `${os.homedir}/workspace/${PNAME}`;

const errors = [];

if (!PNAME || typeof PNAME !== "string") {
  errors.push(`${ERROR}: No project name provided`);
}

const allowed_args = ["h", "help", "p", "private", "a", "ai", "e", "emoji"];
const unknownArgs = Object.keys(argv).filter(
  (a) => !allowed_args.includes(a) && a !== "_"
);

if (unknownArgs.length > 0) {
  errors.push(
    `${ERROR}: Received unknown args ${unknownArgs.map((a) =>
      chalk.italic(`${a.length === 1 ? "-" : "--"}${a}`)
    )}\n`
  );
}

if (errors.length > 0) {
  errors.forEach((e) => {
    console.log(e);
  });
  console.log(`${USAGE}`);
  await $`exit 5;`;
}

await spinner(`Creating project ${chalk.cyan(PNAME)}...`, async () => {
  cd(`${os.homedir}/workspace`);

  const flags = [
    "--add-readme",
    ...(IS_PRIVATE ? ["--private"] : ["--public"]),
  ];

  try {
    await $`gh repo create ${PNAME} ${flags}`;
    await $`gh repo clone ${PNAME}`;
    cd(PROJ_DIR);
  } catch {
    console.log("Could not create repo with GH CLI. Creating manually...");
    await $`mkdir -p ${PROJ_DIR}`;
    cd(PROJ_DIR);
    await $`git init`;
    await fs.writeFileSync(`${PROJ_DIR}/README.md`, `# ${PNAME}`);
    await $`git add .`;
    await $`git commit -m 'Initial commit'`;
  }
});

await spinner(
  `Initializing Poetry project with dev dependencies...`,
  async () => {
    cd(PROJ_DIR);
    await $`mkdir -p ${PROJ_DIR}/${PNAME}/src`;
    await $`poetry init -n -q`;
    await $`poetry add -nq -G dev ${DEV_DEPS}`;
  }
);

await spinner(
  `Copying project template...\nWith Emoji: ${
    USE_EMOJI ? chalk.green(USE_EMOJI) : chalk.red(USE_EMOJI)
  }\nWith AI: ${USE_AI ? chalk.green(USE_AI) : chalk.red(USE_AI)}`,
  async () => {
    await $`cp ${TEMP_DIR}/py.gitignore ${PROJ_DIR}/.gitignore`;
    await $`cp ${TEMP_DIR}/pyrightconfig.json ${PROJ_DIR}/.`;
    await $`cp ${TEMP_DIR}/.pre-commit-config.yaml ${PROJ_DIR}/.`;
    await $`cp ${TEMP_DIR}/Makefile ${PROJ_DIR}/.`;
    await $`cp ${TEMP_DIR}/src/* ${PROJ_DIR}/${PNAME}/src/.`;

    if (USE_EMOJI) {
      await $`cp ${TEMP_DIR}/emoji.commitlint.config.js ${PROJ_DIR}/temp.js`;
    } else {
      await $`cp ${TEMP_DIR}/commitlint.config.js ${PROJ_DIR}/temp.js`;
    }

    if (USE_AI) {
      const config = JSON.stringify({
        ...require(`${PROJ_DIR}/temp.js`),
        prompt: {
          ...require(`${PROJ_DIR}/temp.js`).prompt,
          useAI: true,
          aiNumber: 3,
        },
      });
      fs.writeFileSync(
        `${PROJ_DIR}/commitlint.config.js`,
        `module.exports = ${config}`
      );
    }
  }
);

await spinner("Creating Poetry environment...", async () => {
  cd(PROJ_DIR);
  await $`poetry install --no-root`;
});

await spinner("Setting up pre-commit...", async () => {
  cd(PROJ_DIR);
  await $`poetry run pre-commit autoupdate`;
  await $`poetry run pre-commit install`;
  await $`poetry run pre-commit install --hook-type commit-msg`;
});

console.log(chalk.black.bold.bgWhite("Complete!"));
cd(PROJ_DIR);
