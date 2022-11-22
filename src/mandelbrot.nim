import std/complex
import imageman
  
const widthOfSet = 10000

proc color(r, g, b: uint8): ColorRGBU =
  ColorRGBU([r, g, b])

proc color(c: int): ColorRGBU =
  color(uint8(c / 245) * 255, 102, 102)

proc mandelbrot_set(c: Complex): ColorRGBU =
  var z = complex(0.0, 0.0)
  for i in 0..900:
    if abs(z) > 2:
      return color(i)
    z = z*z + c
  color(0, 0, 0)

proc generate_image(): Image[ColorRGBU] =
  var image = initImage[ColorRGBU](widthOfSet, (widthOfSet / 2).Natural)
  for i in 0..<image.height:
    for j in 0..<image.width:
      let real = (j.float - (0.75*widthOfSet)) / (widthOfSet/4)
      let imag = (i.float - (widthOfSet/4)) / (widthOfSet/4)
      let complex = complex(real, imag)
      image.data[i * image.width + j] = mandelbrot_set(complex)
  image

proc run() =
  var image = generate_image()
  image.savePNG("mandelbrot_set.png")
  
when isMainModule:
  run()
