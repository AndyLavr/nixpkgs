{ stdenv, unzip, fetchzip, libX11, mesa }:

stdenv.mkDerivation rec {
  name = "ant-tweak-bar-${version}";
  version = "116";

  src = fetchzip {
    url = "http://ufpr.dl.sourceforge.net/project/anttweakbar/AntTweakBar_${version}.zip";
    sha256 = "16716qq9zaiknvwaz2jgc676dqnbqmqqy4vi4kxpbvig38wabwb1";
  };

  buildInputs = [
    libX11 mesa
  ];

  preBuild = "rm lib/*";

  makeFlags = "-C src";

  installPhase = ''
    mkdir -p $out
    cp -r include $out
    cp -r lib $out
  '';

  meta = with stdenv.lib; {
    description = "A small and easy-to-use C/C++ library that allows programmers to quickly add a light and intuitive GUI into OpenGL or DirectX based graphic programs";
    homepage = http://anttweakbar.sourceforge.net;
    maintainers = [ maintainers.corngood ];
    platforms = platforms.linux;
    license = licenses.zlib;
  };
}
