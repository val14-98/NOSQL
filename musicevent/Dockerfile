FROM fanoftal2/flask-crud-base:1

ADD ./app /home/app/
WORKDIR /home/app/

EXPOSE 5000
RUN python3 -m pip install psycopg2-binary>=2.8
RUN python3 -m pip install pymongo ##


ENTRYPOINT ["python3", "app.py"]
