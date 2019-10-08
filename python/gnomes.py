import json


jobs = []
hair_colors = []

def add_job(job):
    if not job in jobs:
        jobs.append(job)

def add_color(color):
    if not color in hair_colors:
        hair_colors.append(color)

if __name__ == "__main__":
    with open('gnomes.json', 'r') as f:
        json_data = json.load(f)

        for data in json_data['Brastlewark']:
            add_color(data['hair_color'])
            for profession in data['professions']:
                add_job(profession)

    print(jobs)
    print(hair_colors)