# AICA

An Interactive Case Archive, or AICA, consists of a number of interactive medical cases for revision. 

Early work in progress.

# Build CSS

Currently using `tailwindcss` for functional component styles and `purgecss` to reduce css size. 

Run:

```
npm run build-css
```

# Configuration

Configuration should be set in a file `Config.elm` in the `src/` directory. An example is below:

```
module Config exposing (backendUrl)


backendUrl : String
backendUrl =
    "https://my-backend-url.com/"

```
