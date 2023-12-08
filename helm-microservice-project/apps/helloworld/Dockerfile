FROM python:3-alpine

WORKDIR /app

COPY src/requirement.txt ./

RUN pip install -r requirement.txt

COPY src /app

EXPOSE 5001

ENTRYPOINT [ "python" ]

CMD [ "hellojson.py" ]