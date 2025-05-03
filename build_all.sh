#!/usr/bin/env sh

cat Aliensevka.toml Brainsevka.toml Firasevka.toml Monasevka.toml Plexsevka.toml Ubunsevka.toml > private-build-plans.toml

npm run build -- ttf::Aliensevka ttf::Brainsevka ttf::Firasevka ttf::Plexsevka ttf::Ubunsevka
