import parser from '@typescript-eslint/parser';

export default {
  files: ['**/*.ts'],
  ignores: ['build/**', 'dist/**', 'example/**'],
  languageOptions: {
    parser,
  },
};
