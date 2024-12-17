#this file should be pasted in nginx/sites-available
#aslo make sudo ln -s /etc/nginx/sites-available/demo-website.com /etc/nginx/sites-enabled/  
#make above symbollic link so that nginx knows that this website has been enabled
# to do -> use multiple dns names

server {
    listen 80;
    server_name localhost;

    #backend 1
    location /demo1/ {
        proxy_pass http://localhost:3000/;  # Node.js backend
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    
    	# Remove /demo1 from the URL path when forwarding to the backend
        rewrite ^/demo1(/.*)$ $1 break;
    }

    #backend 2
    location /demo2/ {
        proxy_pass http://localhost:4000/; 
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # Remove /demo2 from the URL path when forwarding to the backend
        rewrite ^/demo2(/.*)$ $1 break;
    }
}
