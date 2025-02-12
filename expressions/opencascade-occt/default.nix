# adapted from github:conda-forge/occt-feedstock which is the canonical cadquery source.
{
  stdenv
  , lib
  , fetchurl
  , fetchpatch
  , cmake
  , ninja
  , tcl
  , tk
  , libGL
  , libGLU
  , libXext
  , libXmu
  , libXi
  , vtk
  , xorg
  , freetype
  , freeimage
  , fontconfig
  , tbb_2021_11
  , rapidjson
  , glew
}:
let
  vtk_version = lib.versions.majorMinor vtk.version;
in
  stdenv.mkDerivation rec {
  pname = "opencascade-occt";
  version = "7.8.1";
  commit = "V${builtins.replaceStrings ["."] ["_"] version}";

  src = fetchurl {
    name = "occt-${commit}.tar.gz";
    url = "https://git.dev.opencascade.org/gitweb/?p=occt.git;a=snapshot;h=${commit};sf=tgz";
    sha256 = "sha256-AGMZqTLLjXbzJFW/RSTsohAGV8sMxlUmdU/Y2oOzkk8=";
  };

  nativeBuildInputs = [ cmake ninja ];
  buildInputs = [
    tcl
    tk
    libGL
    libGLU
    libXext
    libXmu
    libXi
    vtk
    xorg.libXt
    freetype
    freeimage
    fontconfig
    tbb_2021_11
    rapidjson
    glew
  ] ++ vtk.buildInputs;

  patches = [
    # NOTE: in https://github.com/conda-forge/occt-feedstock/commit/2d8e7d1ee4d2ac6210be5db509f3e29705707650, blobfish.patch was split into a bunch of separate patches. do we need them all?

    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0001-cmake-Don-t-try-to-write-to-install-directory.-You-k.patch";
      sha256 = "sha256-oaProXd1JGlQgAH7mOlp3VuqKaSwZyuW7xlijOoEUzY=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0002-GeomPlate_BuildAveragePlane-BasePlan-Don-t-set-yvect.patch";
      sha256 = "sha256-44X0xl4NLzrizV+1nbTKz+w6PcrUsVsqwTJKyTrhz90=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0003-BRepFill_Filling-WireFromList-We-can-t-assume-that-a.patch";
      sha256 = "sha256-CByTdxpQ5hWaNSnzIBIH47Brj4y5Uu5S4apFFVX0X44=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0004-BRepFill_Filling-Curve-constraints-confused-by-impli.patch";
      sha256 = "sha256-LbnC/lUW63LbqclrXD5SYAqJssy4LQWhPiM/ZVGL52s=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0005-BRepFill_Filling-Don-t-even-attempt-to-build-with-em.patch";
      sha256 = "sha256-GPeUvhpsgIiijpI3C871x28q1om+rlwzUl284W0XVxI=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0006-BRepOffset_Tool-TryProject-Check-return-of-BRepLib-B.patch";
      sha256 = "sha256-+BwWXp4LQwPNeTHhVbjCLKvAKwlQX6iOJq1zxn7W44U=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0007-ChFi3d_Builder-ChFi3d_ComputeCurves-set-tolreached-f.patch";
      sha256 = "sha256-cnrtI1kujzYRpT0qNxWsAZvC4oMkcUqDC+XU+W0VRCY=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0008-BRepLib-MakeEdge-Setting-closed-flag-of-generated-ed.patch";
      sha256 = "sha256-5FGryRl8LdxbxmZtUmXDbVMD9nt7XiU4puGSp/JQ9OI=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0009-BRepFill_CompatibleWires-segfault.-See-following.patch";
      sha256 = "sha256-UlEaLz7uMu0klNbYS8CyYgAmJ0RbyeZUl1CgOSCom4U=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0010-BRepFill_OffsetWire-segfault.-See-following.patch";
      sha256 = "sha256-TYFQyK5A1E/El+i9SQd+s7fo4xpyHUsHsKYDK7OxKnc=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0011-ChFiDS_FilSpine-Allow-usage-of-externally-assigned-l.patch";
      sha256 = "sha256-qfUOfkOP26OVVgaVEwbWTqARTpxBcdDiFOXbVvmJ6ic=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0013-BRepFill_PipeShell-Fix-segfault-with-line-as-profile.patch";
      sha256 = "sha256-SCIXXzmMSsxh5B4/s6Hi4JC4/I3/+LQzk7tvibLml34=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0015-build-Expand-preprocessor-conditional-on-non-standar.patch";
      sha256 = "sha256-0ar6dyFQUOJvWDPYRSlk1eMrxyKIZtXtWMuG50TIuxw=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0016-IntPatch_Intersection-Consider-intersection-of-a-clo.patch";
      sha256 = "sha256-zTCfuckptku0ohbK4DHZDo+OUGg4JPmhvpmjN/BpCu4=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0017-ChFi3d_Builder-Fix-blend-across-seam.-See-following.patch";
      sha256 = "sha256-Q3zsTuVC8h8JUUVKojSCqoespGtX5i6ptuTVqSOErq0=";
    })
    (fetchpatch {
      url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/74f888432c34c2ac43249823bf6c4d205af32d8d/recipe/patches/0018-Fix-0033576-BRepTools_NurbsConvertModification-NewPo.patch";
      sha256 = "sha256-mQMq+n1eCTYn8lBHJtdAtY9gtcqyrL3596zcBTOyXW4=";
    })

    # (fetchpatch {
    #   url = "https://raw.githubusercontent.com/conda-forge/occt-feedstock/00ff0f68644d9582a4c30c01220e7de0f934d427/recipe/patches/blobfish.patch";
    #   sha256 = "sha256-5tqkx7W7VBw7qaseFgwBENKbGQ0iUYEL6SJHwGI9L/g=";
    # })

    # TODO: do we need this patch either?  - yes we do

    (fetchpatch {
      url = "https://github.com/Open-Cascade-SAS/OCCT/commit/7236e83dcc1e7284e66dc61e612154617ef715d6.patch";
      sha256 = "sha256-NoC2mE3DG78Y0c9UWonx1vmXoU4g5XxFUT3eVXqLU60=";
    })
  ];

  # I've removed the 3RDPARTY_DIR flag, not really sure if it's needed or not
  cmakeFlags = [
    "-D BUILD_MODULE_Draw:BOOL=OFF"
    "-D USE_TBB:BOOL=ON"
    "-D BUILD_RELEASE_DISABLE_EXCEPTIONS=OFF"
    "-D USE_VTK:BOOL=ON"
    "-D 3RDPARTY_VTK_LIBRARY_DIR:FILEPATH=${vtk}/lib"
    "-D 3RDPARTY_VTK_INCLUDE_DIR:FILEPATH=${vtk}/include/vtk"
    "-D VTK_RENDERING_BACKEND:STRING=\"OpenGL2\""
    "-D USE_FREEIMAGE:BOOL=ON"
    "-D USE_RAPIDJSON:BOOL=ON"
  ];

  seperateDebugInfo = true;

  meta = with lib; {
    description = "Open CASCADE Technology, libraries for 3D modeling and numerical simulation";
    homepage = "https://www.opencascade.org/";
    license = licenses.lgpl21;  # essentially...
    # The special exception defined in the file OCCT_LGPL_EXCEPTION.txt
    # are basically about making the license a little less share-alike.
    maintainers = with maintainers; [ marcus7070 ];
    platforms = platforms.all;
  };

}
