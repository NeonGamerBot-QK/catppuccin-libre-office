_default:
  @just --list
setup:
    mkdir -p themes
clean:
    rm -rf themes
test:
  cd themes/mocha/mauve
  echo $PWD
  cp themes/mocha/mauve/*.soc $HOME/libreoffice/*/user/config/
  bash themes/mocha/mauve/install.sh
undo-test:
  cd ~/.config/libreoffice/*/user
  rm -rf config/*.soc
  rm registrymodifications.xcu
build:
  whiskers templates/libreoffice-soc.tera
  whiskers templates/libreoffice-xcu.tera