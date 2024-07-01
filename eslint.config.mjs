import js from "@eslint/js";
import globals from "globals";

export default [
  {
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "module",
      globals: {
        ...globals.node,
        ...globals.jest,
      },
    },
    rules: {
      // tus reglas personalizadas
    },
  },
  js.configs.recommended,
];
