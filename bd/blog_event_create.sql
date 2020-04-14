CREATE 
	EVENT `archive_blogs` 
	ON SCHEDULE EVERY 1 WEEK STARTS '2011-07-24 03:00:00' 
	DO BEGIN
	
		-- copy deleted posts
		INSERT INTO blog_archive (id, title, content) 
		SELECT id, title, content
		FROM blog
		WHERE deleted = 1;
	    
		-- copy associated audit records
		INSERT INTO audit_archive (id, blog_id, changetype, changetime) 
		SELECT audit.id, audit.blog_id, audit.changetype, audit.changetime 
		FROM audit
		JOIN blog ON audit.blog_id = blog.id
		WHERE blog.deleted = 1;
		
		-- remove deleted blogs and audit entries
		DELETE FROM blog WHERE deleted = 1;
	    
	END $$
