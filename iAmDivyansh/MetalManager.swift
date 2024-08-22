import MetalKit

class Coordinator: NSObject, MTKViewDelegate {
    var shaderName: String?
    var pipelineState: MTLRenderPipelineState?
    var time: Float = 0.0

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}

    func draw(in view: MTKView) {
        guard let device = view.device, let commandQueue = device.makeCommandQueue(), let renderPassDescriptor = view.currentRenderPassDescriptor else {
            return
        }

        let commandBuffer = commandQueue.makeCommandBuffer()
        let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)

        // Update time
        time += 1 / Float(view.preferredFramesPerSecond)

        // Ensure pipeline state is created
        if pipelineState == nil {
            let library = device.makeDefaultLibrary()
            let vertexFunction = library?.makeFunction(name: "vertex_main")
            let fragmentFunction = library?.makeFunction(name: shaderName ?? "timeLines")

            let pipelineDescriptor = MTLRenderPipelineDescriptor()
            pipelineDescriptor.vertexFunction = vertexFunction
            pipelineDescriptor.fragmentFunction = fragmentFunction
            pipelineDescriptor.colorAttachments[0].pixelFormat = view.colorPixelFormat

            pipelineState = try? device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        }

        renderEncoder?.setRenderPipelineState(pipelineState!)

        // Set the time value for the shader
        renderEncoder?.setFragmentBytes(&time, length: MemoryLayout<Float>.size, index: 0)

        // Draw a full-screen quad
        let vertices: [Float] = [-1, -1, 1, -1, -1, 1, 1, 1]
        renderEncoder?.setVertexBytes(vertices, length: vertices.count * MemoryLayout<Float>.size, index: 0)

        renderEncoder?.drawPrimitives(type: .triangleStrip, vertexStart: 0, vertexCount: 4)

        renderEncoder?.endEncoding()
        commandBuffer?.present(view.currentDrawable!)
        commandBuffer?.commit()
    }
}
