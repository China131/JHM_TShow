//
//  Shader.vsh
//  EmitterDrawer
//
//  Created by mango on 7/22/13.
//  Copyright (c) 2013 mango. All rights reserved.
//

attribute vec4 position;
attribute vec2 texcoord;
varying vec2 texcoordOut;
varying vec2 texcoordSrc;


uniform mat4 projectionMatrix;
uniform mat4 modelviewMatrix;
void main()
{
    gl_Position = projectionMatrix * modelviewMatrix * position;
    texcoordSrc = gl_Position.xy*0.5+0.5;
    texcoordOut = texcoord;
}
