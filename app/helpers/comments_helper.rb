module CommentsHelper
    
    def nested_level(comment)
        level = 0
        parent_level = check_comment_id_and_get_parent(comment)
        level + parent_level
    end
    
    def check_comment_id_and_get_parent(comment)
        level = 0
        parent_level = 0
    
        if comment.parent_comment_id != nil
            level += 1
            parent_comment = comment.parent_comment
    
            if parent_comment.parent_comment_id != nil
                parent_level = check_comment_id_and_get_parent(parent_comment)
            end
        end
    
        level + parent_level
    end
    
end
