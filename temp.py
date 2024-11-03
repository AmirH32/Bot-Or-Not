import requests
import json

# url = "https://api.mistral.ai/v1/models"  # Replace with your actual API endpoint
# api_key = "QH83AGDmjqANw1jBEaJXmm9osl5KfUwf"  # Your Bearer token

# print("hello")

# headers = {
#     "Authorization": f"Bearer {api_key}",
#     "Content-Type": "application/json"
# }

# response = requests.get(url, headers=headers)

# if response.status_code == 200:
#     data = response.json()
#     print("Response:", data)
#     for i in data["data"]:
#         print(i["name"])
# else:
#     print("Request failed with status code:", response.status_code)

#     import requests
# import json

# Replace 'YOUR-TOKEN' with your actual token
key = "GI6FOF1DRZWKAIMJWHAJP11VLOVUY1QD"
import requests
from pprint import pprint

response = requests.post(
    "https://api.sapling.ai/api/v1/aidetect",
    json={
        "key": key,
        "text": "I can't check the current weather for you, but you can easily find it by searching online or using a weather app. If you let me know your location, I can suggest what you might expect based on typical weather patterns!"
    }
)

pprint(response.json())

