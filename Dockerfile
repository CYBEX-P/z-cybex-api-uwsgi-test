FROM nginx

RUN apt update
RUN apt install -y sudo python3 python3-pip virtualenv

#RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak
COPY ./cybex-api-nginx.conf /etc/nginx/conf.d/

# --gecos ""
#RUN useradd -p '*' -ms /bin/bash  cybex-user
COPY ./ /app
#RUN chown -R cybex-user:nginx /home/cybex-user/app
# USER cybex-user
# WORKDIR /home/cybex-user/app



#COPY ./00-poster.conf /etc/nginx/conf.d/

#RUN virtualenv venv -p python3
#RUN . venv/bin/activate




# USER root
COPY ./cybex-api.service /etc/systemd/system/
#RUN pip3 install --user -r requirements.txt
RUN pip3 install wheel uwsgi flask

#RUN systemctl start cybex-api
#RUN systemctl enable cybex-api
#RUN mkdir /etc/nginx/sites-enabled
#RUN ln -s /etc/nginx/sites-available/cybex-api-nginx.conf /etc/nginx/sites-enabled/
RUN nginx -t
#RUN systemctl restart nginx
#RUN systemctl enable nginx

#RUN nginx

#USER cybex-user
WORKDIR /app
#RUN . venv/bin/activate

EXPOSE 80
#EXPOSE 5000


#CMD uwsgi --socket 0.0.0.0:5000 --protocol=http -w wsgi:app

CMD nginx && uwsgi --ini /app/uwsgi.ini --enable-threads
#CMD tail -f /dev/null
#CMD echo HI