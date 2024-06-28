/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/**/*.*ex",
    "../priv/*/views/**/*.ex",
    "../priv/*/templates/**/*.eex",
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('flowbite/plugin')
  ],
}