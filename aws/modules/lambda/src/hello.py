import json
import boto3
import os
import uuid

TABLE_NAME = os.environ.get('TABLE_NAME')

def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(TABLE_NAME)
    
    record_id = str(uuid.uuid4())
    
    table.put_item(
        Item={
            'id': record_id,
            'message': 'Merhaba Mert! Bu veri DynamoDB\'den geliyor.',
            'timestamp': '2026-01-22' 
        }
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps(f'Veri kaydedildi! ID: {record_id}')
    }