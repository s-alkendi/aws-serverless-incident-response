import json
import boto3
import urllib.parse

# --- Global AWS Service Clients ---
s3 = boto3.client('s3')
rekognition = boto3.client('rekognition')
sns = boto3.client('sns')

def lambda_handler(event, context):
    """
    Automated Visual Threat Intelligence Pipeline
    Logic: Triggered by S3 upload -> AI Image Analysis -> SNS Incident Alert
    """
    
    # Configuration: Replace with your specific SNS Topic ARN
    my_topic_arn = 'arn:aws:sns:us-east-1:717279718874:ImageModerationTopic'
    
    try:
        # 1. Ingest event data from S3
        bucket = event['Records'][0]['s3']['bucket']['name']
        raw_key = event['Records'][0]['s3']['object']['key']
        image_name = urllib.parse.unquote_plus(raw_key)
        
        print(f"Initiating security audit for asset: {image_name}")
        
        # 2. Invoke Amazon Rekognition for deep-learning-based object detection
        # MinConfidence 70 ensures high-precision results
        response = rekognition.detect_labels(
            Image={'S3Object': {'Bucket': bucket, 'Name': image_name}},
            MaxLabels=10,
            MinConfidence=70
        )
        
        found_weapon = False
        weapon_name = ""
        confidence_score = 0
        
        # 3. Filter results for restricted item classification (Knife)
        for label in response['Labels']:
            if label['Name'] == 'Knife':
                found_weapon = True
                weapon_name = label['Name']
                confidence_score = label['Confidence']
                break 
        
        # 4. Conditional logic for automated incident response
        if found_weapon:
            print(f"ALERT: {weapon_name} identified with {confidence_score}% confidence.")
            
            # Format high-priority security report
            alert_body = (
                "*** SECURITY ALERT: RESTRICTED ITEM DETECTED ***\n"
                "------------------------------------------------\n"
                f"Incident Type: Unauthorized Weaponry ({weapon_name})\n"
                f"Confidence Level: {round(confidence_score, 2)}%\n"
                f"S3 Object URI: s3://{bucket}/{image_name}\n"
                "Response Action: Immediate notification dispatched to SOC.\n"
            )
            
            sns.publish(
                TopicArn=my_topic_arn,
                Subject="[URGENT] Security Breach: Weapon Detected",
                Message=alert_body
            )
        else:
            print("Audit successful: No security threats detected.")

        return {
            'statusCode': 200,
            'body': json.dumps('Security Audit Finalized')
        }

    except Exception as e:
        # Professional error handling and logging
        print(f"Operational Error: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps('Internal Processing Failure')
        }
