module ApplicationHelper

    def bytes_to_megabytes(bytes)
        (bytes.to_f / 1024000).round(2)
    end
    
    def bytes_to_kilobytes(bytes)
        bytes / 1024
    end
    
end
