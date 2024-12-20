{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchurl,
  autoconf,
  automake,
  cmake,
  curl,
  libgcc,
  libtool,
  openssl,
  perl,
  policycoreutils,
  python312,
  zstd,
}:
let
  dependencyVersion = "24";
  fetcher = (
    { name, sha256 }:
    fetchurl {
      url = "https://packages.wazuh.com/deps/${dependencyVersion}/libraries/sources/${name}.tar.gz";
      inherit sha256;
    }
  );
  dependencies = [
    (fetcher {
      name = "cJSON";
      sha256 = "678d796318da57d5f38075e74bbb3b77375dc3f8bb49da341ad1b43c417e8cc1";
    })
    (fetcher {
      name = "curl";
      sha256 = "sha256-ULsVkySx7DjKdrM4ujcJ8MDahnhoChKp0wXx2Pcmsl0=";
    })
    (fetcher {
      name = "libdb";
      sha256 = "sha256-fpxE6Mf9sYb/UhqNCFsb+mNNNC3Md37Oofv5qYq13F4=";
    })
    (fetcher {
      name = "libffi";
      sha256 = "sha256-DpcfZLrMIglOifA0u6B1tA7MLCwpAO7NeuhYFf1sn2k=";
    })
    (fetcher {
      name = "libyaml";
      sha256 = "sha256-NdqtYIs3LVzgmfc4wPIb/MA9aSDZL0SDhsWE5mTxN2o=";
    })
    (fetcher {
      name = "openssl";
      sha256 = "sha256-konM9rgnYlaaGDrXGnRYcu/1HxCJx31YsMTvD3YeAog=";
    })
    (fetcher {
      name = "procps";
      sha256 = "sha256-Ih85XinRvb5LrMnbOWAu7guuaFqTVDe+DX/rQuMZLQc=";
    })
    (fetcher {
      name = "sqlite";
      sha256 = "sha256-5oUhY32eTmARVwfNfzUnWpLObQ/B/wTiLXu/DDk/j/E=";
    })
    (fetcher {
      name = "zlib";
      sha256 = "sha256-2iKcKsAcVy1rAAhfu7sUE4LIGO0pKZCTFTUl+EsCew0=";
    })
    (fetcher {
      name = "audit-userspace";
      sha256 = "sha256-6Coy5e35OwVRYOFLyX9B3q05KHklhR3ICnY44tTTBDQ=";
    })
    (fetcher {
      name = "msgpack";
      sha256 = "sha256-BtY7zzKJbNCvVIDEARNLGtHBZv2E6+W0hueSEB7oVOI=";
    })
    (fetcher {
      name = "bzip2";
      sha256 = "sha256-J2iO4DFqZLOeURssIkBwytl8OUpfcR+dBV/BgJ2JW80=";
    })
    (fetcher {
      name = "nlohmann";
      sha256 = "sha256-zvsHk209W/3T78Xpu408gH1oEnO9rC6Ds9Z67y0RWMQ=";
    })
    (fetcher {
      name = "googletest";
      sha256 = "sha256-jB6KCn8iHCEl6Z5qy3CdorpHJHa00FfFjeUEvr841Bc=";
    })
    (fetcher {
      name = "libpcre2";
      sha256 = "sha256-0Lr8NXn6CvCjmVFYbt+jSeH0voPSi+2Gq+Cj/Es0/Po=";
    })
    (fetcher {
      name = "libplist";
      sha256 = "sha256-iCeNS9/BvWo6GlWk89kzaD0nMroJz3p0n+jsjuxAbjw=";
    })
    (fetcher {
      name = "pacman";
      sha256 = "sha256-9n3Tiir7NA19YDUNSbdamDp8TgGtdgIFaSDv6EnVsUM=";
    })
    (fetcher {
      name = "libarchive";
      sha256 = "sha256-+GPzgurZ9hq8Vg/w6tC+OqnpW2+MYnVuHwNPTCOGunk=";
    })
    (fetcher {
      name = "popt";
      sha256 = "sha256-1ogKBmIsoy3EqjmtXc977y+qgb2TGvvmS6Q0rY/uHao=";
    })
    (fetcher {
      name = "rpm";
      sha256 = "sha256-TLxfyjwT3y3RUBLGi81SMH0omhvn6TxkjZ4P44ezFnA=";
    })
    (fetcher {
      name = "cpython";
      sha256 = "sha256-Ct2yYX/g3PnnVvt9gOb1Uffqb/DCLIfcP8rTBva6yrA=";
    })
    (fetcher {
      name = "jemalloc";
      sha256 = "sha256-KyLoWzUsffVQukCKQiUeUejf+myRqi4ftIBKsxf/vKA=";
    })
  ];
in
stdenv.mkDerivation rec {
  pname = "wazuh-agent";
  version = "4.7.3";

  meta = {
    description = "Wazuh agent for NixOS";
    homepage = "https://wazuh.com";
    maintainers = builtins.attrValues {
      inherit (lib.maintainers) V3ntus sjdwhiting;
    };
  };

  src = fetchFromGitHub {
    owner = "wazuh";
    repo = "wazuh";
    rev = "v${version}";
    sha256 = "sha256-h9gMAjE09f6nQ9zO7wdC+fspLKE6z5tlypHzdObJRGA=";
  };

  workingDirectory = "${stdenv.system}-src";

  env = {
    OSSEC_LIBS = "-lzstd";
  };

  buildInputs = [
    autoconf
    automake
    cmake
    curl
    stdenv.cc.libcxx
    stdenv.cc.coreutils_bin
    libtool
    openssl
    perl
    policycoreutils
    python312
    zstd
  ];

  unpackPhase = ''
    mkdir -p $workingDirectory/src/external
    cp --no-preserve=all -rf $src/* $workingDirectory
    ${lib.strings.concatMapStringsSep "\n" (
      dep: "tar -xzf ${dep} -C $workingDirectory/src/external"
    ) dependencies}
  '';

  patchPhase = ''
    # Patch audit_userspace autogen.sh script
    substituteInPlace $workingDirectory/src/external/audit-userspace/autogen.sh \
      --replace-warn "cp INSTALL.tmp INSTALL" ""

    # Required for OpenSSL to compile
    # Patch the script to use the Nix store path directly for Perl
    substituteInPlace $workingDirectory/src/external/openssl/config \
      --replace-warn "/usr/bin/env" "env"

    # Bypass check for tar file
    touch $workingDirectory/src/external/cpython.tar

    cat << EOF > "$workingDirectory/etc/preloaded-vars.conf"
    USER_LANGUAGE="en"
    USER_NO_STOP="y"
    USER_INSTALL_TYPE="agent"
    USER_DIR="$out"
    USER_DELETE_DIR="n"
    USER_ENABLE_ACTIVE_RESPONSE="y"
    USER_ENABLE_SYSCHECK="y"
    USER_ENABLE_ROOTCHECK="y"
    USER_ENABLE_OPENSCAP="y"
    USER_ENABLE_SYSCOLLECTOR="y"
    USER_ENABLE_SECURITY_CONFIGURATION_ASSESSMENT="y"
    USER_AGENT_SERVER_IP=127.0.0.1
    USER_CA_STORE="no"
    EOF

    ln -sf ${libgcc.lib}/lib/libgcc_s.so.1 $workingDirectory/src/libgcc_s.so.1
    ln -sf ${libgcc.lib}/lib/libstdc++.so.6 $workingDirectory/src/libstdc++.so.6
  '';

  dontConfigure = true;

  makeFlags = [
    "-C ${workingDirectory}/src"
    "TARGET=agent"
    "INSTALLDIR=$out"
  ];

  preBuild = ''
    make -C $workingDirectory/src deps
  '';

  enableParallelBuilding = true;

  dontFixup = true;

  installPhase = ''
    mkdir -p $out/{bin,etc/shared,queue,var,wodles,logs,lib,tmp,agentless,active-response}

    # Bypass root check
    substituteInPlace $workingDirectory/install.sh \
      --replace-warn "Xroot" "Xnixbld"
    chmod u+x $workingDirectory/install.sh

    # Allow files to copy over even if permissions are not changed
    substituteInPlace $workingDirectory/src/init/inst-functions.sh \
      --replace-warn "WAZUH_GROUP='wazuh'" "WAZUH_GROUP='nixbld'" \
      --replace-warn "WAZUH_USER='wazuh'" "WAZUH_USER='nixbld'"

    cd $workingDirectory # Must run install from src
    INSTALLDIR=$out USER_DIR=$out ./install.sh binary-install

    chmod u+x $out/bin/* $out/active-response/bin/*
    rm -rf $out/src # Remove src
  '';
}
