#include <metal_stdlib>
using namespace metal;

struct VertexOut {
    float4 position [[position]];
    float4 color;
};

vertex VertexOut vertex_main(const device packed_float2* vertex_array [[buffer(0)]],
                             unsigned int vid [[vertex_id]]) {
    VertexOut out;
    float2 pos = vertex_array[vid];
    out.position = float4(pos, 0.0, 1.0);
    out.color = float4(1.0, 1.0, 1.0, 1.0); // White color for now
    return out;
}

fragment float4 timeLines(float4 inColor [[stage_in]],
                          constant float& time [[buffer(0)]]) {
    // Create a simple animated line effect based on time
    float alpha = abs(sin(time)); // Animation effect using sine wave
    return float4(inColor.rgb, alpha); // Return color with animated alpha
}
