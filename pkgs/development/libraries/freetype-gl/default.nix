{ stdenv, fetchgit, cmake, mesa, freetype, glew, doxygen
, glfw3, imagemagick, ant-tweak-bar, fontconfig }:

stdenv.mkDerivation rec {
  name = "freetype-gl";
  rev = "709dc8b3a7c2743f2a20a9286b5aaad8aa6ce027";

  src = fetchgit {
    inherit rev;
    url = https://github.com/rougier/freetype-gl.git;
    sha256 = "0jmw8h4d5iy6ajskr6773yy1x6q60l6a84biynkv0lwg7iar623i";
  };

  outputs = [ "out" "dev" ];

  patches = [ ./shared.patch ];

  cmakeFlags = [
    "-Dfreetype-gl_USE_VAO=ON"
    "-Dfreetype-gl_BUILD_DEMOS=OFF"
    "-Dfreetype-gl_BUILD_TESTS=OFF"
  ];

  buildInputs = [
    cmake mesa freetype glew doxygen glfw3 imagemagick ant-tweak-bar fontconfig
  ];

  installPhase = ''
    mkdir -p $out/bin $out/lib $dev/include/freetype-gl
    cp makefont $out/bin
    cp libfreetype-gl.so $out/lib
    cp ../*.h $dev/include/freetype-gl
  '';

  meta = with stdenv.lib; {
    description = "OpenGL text using one vertex buffer, one texture and FreeType";
    homepage = https://github.com/rougier/freetype-gl;
    maintainers = [ maintainers.corngood ];
    license = licenses.bsd2;
  };
}
