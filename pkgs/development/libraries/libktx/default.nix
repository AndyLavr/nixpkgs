{ stdenv, fetchFromGitHub, mesa }:

let
  version = "git";

in stdenv.mkDerivation rec {
  name = "libktx-${version}";

  src = fetchFromGitHub {
    owner = "KhronosGroup";
    repo = "KTX";
    rev = "ceba133bee407dd575226f259af5af4d4471999f";
    sha256 = "1ccbhx95nqh4jzci0zrz2c67r6xdz6mp6lqbpz3wh3g01dc3y55x";
  };

  outputs = [ "out" "dev" ];

  buildInputs = [ mesa ];

  makeFlags = "-C build/make/linux BUILDTYPE=Release libktx.gl toktx";

  installPhase = ''
    mkdir -p $out/bin $out/lib $dev
    cp build/make/linux/out/Release/toktx $out/bin
    cp build/make/linux/out/Release/lib.target/libktx.gl.so $out/lib
    cp -r include $dev
  '';

  meta = with stdenv.lib; {
    description = "KTX (Khronos Texture) is a lightweight file format for OpenGL textures, designed around how textures are loaded in OpenGL.";
    homepage = https://github.com/KhronosGroup/KTX;
    license = licenses.bsd;
    platforms = platforms.all;
    maintainers = [ maintainers.corngood ];
  };
}
