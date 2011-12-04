class Queue
    constructor: (@name) ->
        @highwaterMark = 256
        @lowwaterMark = 64
        
        @finished = false
        @buffering = true
        
        @onHighwaterMark = null
        @onLowwaterMark = null
        
        @buffers = []
        
        @inputs = {
            contents:
                send: (buffer) => this.enqueueBuffer(buffer)
                mode: "Passive"
            
        }
        
        @outputs = {
            contents:
                receive: () => this.dequeueBuffer()
                mode: "Pull"
            
        }
        
        this.reset()
    
    enqueueBuffer: (buffer) ->
        @buffers.push(buffer)
        
        if @buffering
            if @buffers.length >= @highWaterMark || buffer.final
                @onHighwaterMark(@buffers.length)
                
                @buffering = false
            
        
        return this
    
    dequeueBuffer: () ->
        result = @buffers.shift()
        
        unless @buffering
            if @buffers.length < @lowWaterMark
                @onLowwaterMark(@buffers.length)
            
        
        return result
    
    start: () ->
        @status = "Started"
        
        return this
    
    pause: () ->
        @status = "Paused"
        
        return this
    
    reset: () ->
        @status = "Paused"
        
        return this
    
    finished: () ->
        @status = "Finished"
        
        return this
    

window.Aurora = {} unless window.Aurora

window.Aurora.Queue = Queue
