/** @type {import('cz-git').UserConfig} */
module.exports = {
  rules: {
    "subject-max-length": [2, "always", 72],
    "subject-case": [2, "always", "lower-case"],
    "subject-empty": [2, "never"],
    "type-enum": [
      2,
      "always",
      ["feat", "fix", "docs", "chore", "refactor", "test", "revert", "ci"],
    ],
    "type-empty": [2, "never"],
  },
  prompt: {
    alias: { ur: "docs: update README" },
    messages: {
      type: "Select the type of change that you're committing:",
      scope: "Denote the SCOPE of this change (optional):",
      customScope: "Denote the SCOPE of this change:",
      subject: "Write a SHORT, IMPERATIVE tense description of the change:\n",
      body: 'Provide a LONGER description of the change (optional). Use "|" to break new line:\n',
      generatingByAI: "Generating your AI commit subject...",
      generatedSelectByAI: "Select suitable subject by AI generated:",
      confirmCommit: "Are you sure you want to proceed with the commit above?",
    },
    types: [
      { value: "feat", name: "feat:     A new feature", emoji: ":sparkles:" },
      { value: "fix", name: "fix:      A bug fix", emoji: ":bug:" },
      {
        value: "docs",
        name: "docs:     Documentation only changes",
        emoji: ":memo:",
      },
      {
        value: "style",
        name: "style:    Changes that do not affect the meaning of the code",
        emoji: ":lipstick:",
      },
      {
        value: "refactor",
        name: "refactor: A code change that neither fixes a bug nor adds a feature",
        emoji: ":recycle:",
      },
      {
        value: "test",
        name: "test:     Adding missing tests or correcting existing tests",
        emoji: ":white_check_mark:",
      },
      {
        value: "ci",
        name: "ci:       Changes to our CI/CD configuration files and scripts",
        emoji: ":ferris_wheel:",
      },
      {
        value: "chore",
        name: "chore:    Other changes that don't modify src or test files",
        emoji: ":hammer:",
      },
      {
        value: "revert",
        name: "revert:   Reverts a previous commit",
        emoji: ":rewind:",
      },
    ],
  },
};
