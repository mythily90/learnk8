from flask import Flask, jsonify, request
import requests
import json


app2 = Flask(__name__)

@app2.route('/',methods = ['GET'])
def ReturnReverse():

    #url = 'http://localhost:5001/'
    url = 'http://helloapp-service.sap.svc.cluster.local:5001'
    response = requests.get(url)
    print(response)
    #data = response.json()
    dictdata=json.loads(json.dumps(response.json()))
    print(dictdata)
    dictdata["message"] = dictdata["message"][::-1]
    return jsonify(dictdata)

if __name__ == '__main__':
    app2.run(port=5002,debug=True,host='0.0.0.0')