---
title: the state of linux graphics software
author: Anna
date: 2022-08-11T15:55:45-07:00
tags: linux

license: CC BY-SA 4.0
---
i've recently been trying to do some graphic design stuff like making posters and images. this meant figuring out the available tooling for this on Linux.

so far, i've tried using a few different programs, each of which has its own flaws.

## GIMP

this is probably the best raster graphics tool available on linux so far. i've been using it for a really long time, much more than pretty much any other graphics software. its UI is idiosyncratic. it was also clearly written by underpaid FOSS devs, meaning that no one's put time into making sure the interface is nice to use. it's just kind of a conglomeration of features. figuring out how to edit gradients took me around twenty minutes, for example.

lots of people compare GIMP to Photoshop. i've never used Photoshop much, and every time i've been put in front of it, i've ended up installing GIMP instead since i'm much more familiar with it. so i can't make that comparison myself.

the flaws in GIMP's UI are just… very rough edges, really. nothing is _broken_, but it feels like all of the tools are clunky in their own way.

- the text tool has two places to configure settings for your text, one "default" group in the left sidebar (by default) that seems to reset itself every time you click away, and one floating dialog that only has a subset of options but is the only way to adjust text you've already entered.
- the move tool makes you click on the image before it works. and this usually ends up imperceptibly shifting your selection so that it is slightly misaligned. there's no other way to do it, you just have to be really really careful with your mouse. it's annoying when you're trying to do graphic design type things that require precise alignment.
  - also, when you're trying to move around text layers, you end up clicking past the text a lot, and selecting whatever is under it. this means you need to go to the layers dialog and select the text layer again manually because clicking the text will just select the layer in the background again.
- there's no way to precisely position anything. you can't put in coordinates for selection corners, for example; you have to zoom in and drag the handle around.

there's a lot of other examples, but i can't think of them right now

## Inkscape


