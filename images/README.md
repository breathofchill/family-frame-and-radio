# Adding Your Family Photos to `images/`

Drop any `.jpg`, `.jpeg`, or `.png` family photos into this `images/` folder.
On launch, **Family Frame & Radio** calls `ListDir("pkg:/images/")` to automatically discover and display all your photos in alphabetical order—no code edits required!

## Optional Channel Icons & Splash Screens
Our `discoverPhotos()` logic automatically excludes files prefixed with `channel_` or `splash_` from the photo slideshow so your Roku Home Screen icon and splash screen won't appear in your family photo rotation:
- `channel_icon_hd.png` (336x210 PNG)
- `channel_icon_sd.png` (248x140 PNG)
- `splash_fhd.png` (1920x1080 PNG)
- `splash_hd.png` (1280x720 PNG)
