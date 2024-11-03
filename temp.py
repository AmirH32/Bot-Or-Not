import requests

url = "https://api.mistral.ai/v1/models"  # Replace with your actual API endpoint
api_key = "QH83AGDmjqANw1jBEaJXmm9osl5KfUwf"  # Your Bearer token

print("hello")

headers = {
    "Authorization": f"Bearer {api_key}",
    "Content-Type": "application/json"
}

response = requests.get(url, headers=headers)

if response.status_code == 200:
    data = response.json()
    print("Response:", data)
    for i in data:
        print(type(i))
else:
    print("Request failed with status code:", response.status_code)
