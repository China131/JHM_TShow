//
//  Shader.fsh
//  EmitterDrawer
//
//  Created by mango on 7/22/13.
//  Copyright (c) 2013 mango. All rights reserved.
//
precision highp float;
varying vec2 texcoordOut;
varying vec4 colorVarying;
varying vec2 texcoordSrc;

uniform sampler2D texture;
uniform sampler2D srcTexture;
uniform sampler2D backbuffer;
uniform mediump float opacity;

void main()
{
    vec4 textureColor = texture2D(texture, texcoordOut); 
    gl_FragColor =textureColor;
}
