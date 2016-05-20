//
//  Shader.fsh
//  EmitterDrawer
//
//  Created by mango on 7/22/13.
//  Copyright (c) 2013 mango. All rights reserved.
//
precision highp float;

varying vec2 texcoordOut;
uniform sampler2D texture;
uniform sampler2D srcTexture;
uniform  float opacity;
varying vec2 texcoordSrc;
void main()
{
    vec4 textureColor = texture2D(texture, texcoordSrc);
    vec4 srcColor = texture2D(srcTexture, texcoordSrc);
    float alpha=textureColor.a*opacity;
    
    vec4 res=srcColor*(1.0-alpha)+textureColor;
    
    gl_FragColor =vec4(res.rgb,1.0);
}
