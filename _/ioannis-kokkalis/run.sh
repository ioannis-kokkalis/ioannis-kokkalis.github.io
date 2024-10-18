#!/bin/bash
rm -rf ./public/ && hugo server --bind="0.0.0.0" --poll 100ms --disableFastRender