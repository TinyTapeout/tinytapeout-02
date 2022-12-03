#!/usr/bin/env python3
import stripe, os, json
stripe.api_key = os.environ['STRIPE_TOKEN']
start_id = "cs_live_b1yJQBXmWxKQKPL4z8P6FDeKvRTW05KOIG8ZBkvod2YRCe5vkxFybIHttA"

from datetime import datetime
with open("project_urls_init.py") as fh:
    urls_header = fh.read()

git_urls = []
open_date = datetime(2022, 11, 8)
start_id = None
after_open_date = True
git_url_to_email_map = {}
while after_open_date:
    checkouts = stripe.checkout.Session.list(limit=10, starting_after=start_id)

    for checkout in checkouts:
        created = datetime.fromtimestamp(checkout['created'])
        if created < open_date:
            after_open_date = False

        if checkout['payment_status'] == 'paid':
            if 'github' in checkout['metadata']:
                git_url = checkout['metadata']['github']
                print(f"{created} : {git_url}")
                git_urls.append(git_url)
                git_url_to_email_map[git_url] = checkout['customer_details']['email']
        # pagination
        start_id = checkout['id']
    
# put in date order
git_urls.reverse()
with open("project_urls.py", 'w') as fh:
    fh.write(urls_header)

    for git_url in git_urls:
        fh.write(f'    "{git_url}",\n')

    fh.write("    ]\n")

with open('git_url_to_email.json', 'w') as fh:
    fh.write(json.dumps(git_url_to_email_map))

print(f"created project_urls.py with {len(git_urls)} projects")
