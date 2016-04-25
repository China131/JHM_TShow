//
//  Shader.vsh
//  EmitterDrawer
//
//  Created by mango on 7/22/13.
//  Copyright (c) 2013 mango. All rights reserved.
//

attribute vec4 position;
attribute vec2 texcoord;
attribute vec4 color;

varying vec4 colorVarying;
varying vec2 texcoordOut;
varying vec2 texcoordSrc;

uniform mat4 projectionMatrix;
uniform mat4 modelviewMatrix;

void main()
{
    gl_Position = projectionMatrix * modelviewMatrix * position;
    texcoordSrc = gl_Position.xy;
    colorVarying = color;
    texcoordOut = texcoord;
}
