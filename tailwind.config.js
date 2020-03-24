module.exports = {
  theme: {
    extend: {
      colors: {
        olive: {
          100: '#F3FAFA',
          200: '#E0F3F2',
          300: '#CEECEA',
          400: '#A9DDDB',
          500: '#84CFCB',
          600: '#77BAB7',
          700: '#4F7C7A',
          800: '#3B5D5B',
          900: '#283E3D',
        },
      },
    },
    fontFamily: {
      "sans": ["Inter", "Arial", "Helvetica", "system-ui", "-apple-system", "BlinkMacSystemFont", "Segoe UI", "Roboto", "Helvetica Neue", "Arial", "Noto Sans", "sans-serif", "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji"]
    }
  },
  variants: {
    backgroundColor: ["hover", "focus", "group-hover", "active"],
    textColor: ["hover", "focus", "group-hover", "active"],
    boxShadow: ["hover", "focus", "active"],
    borderColor: ["hover", "focus", "active"],
  },
  plugins: [],
}
