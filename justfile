_default:
  @just --list
setup:
    mkdir -p themes
clean:
    rm -rf themes

build:
  whiskers libreoffice-soc.tera
  whiskers libreoffice-xcu.tera
  whiskers libreoffice-sh.tera
  node scripts/change_hex_to_numbers.js