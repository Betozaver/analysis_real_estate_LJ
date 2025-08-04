import undetected_chromedriver as uc
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time
import random

# Optional: Set up headless mode
options = webdriver.ChromeOptions()
# options.add_argument("--headless")  # Uncomment to run without a GUI

# Start the browser


names = [
    ("Nina Horvat", "nina.horvat@051274803.xyz"),
    ("Carlos Mendes", "carlos.mendes@051274803.xyz"),
    ("Emily Zhao", "emily.zhao@051274803.xyz"),
    ("Tariq Aziz", "tariq.aziz@051274803.xyz"),
    ("Sanja Marković", "sanja.markovic@051274803.xyz"),
    ("Hassan El-Sayed", "hassan.elsayed@051274803.xyz"),
    ("Olivia Brooks", "olivia.brooks@051274803.xyz"),
    ("Marco Rinaldi", "marco.rinaldi@051274803.xyz"),
    ("Sara Abdi", "sara.abdi@051274803.xyz"),
    ("Kenta Mori", "kenta.mori@051274803.xyz"),
    ("Lana Petrović", "lana.petrovic@051274803.xyz"),
    ("Dmitry Ivanov", "dmitry.ivanov@051274803.xyz"),
    ("Grace Lee", "grace.lee@051274803.xyz"),
    ("Aliyah Khan", "aliyah.khan@051274803.xyz"),
    ("Jakub Nowak", "jakub.nowak@051274803.xyz"),
    ("Renée Dubois", "renee.dubois@051274803.xyz"),
    ("Seif Nasser", "seif.nasser@051274803.xyz"),
    ("Iris Janssen", "iris.janssen@051274803.xyz"),
    ("Thanh Nguyen", "thanh.nguyen@051274803.xyz"),
    ("Ella Bergström", "ella.bergstrom@051274803.xyz"),
    ("Mohammed Rahman", "mohammed.rahman@051274803.xyz"),
    ("Bianca Rossi", "bianca.rossi@051274803.xyz"),
    ("David Popescu", "david.popescu@051274803.xyz"),
    ("Yara Fakhoury", "yara.fakhoury@051274803.xyz"),
    ("Jonathan Green", "jonathan.green@051274803.xyz"),
    ("Minji Park", "minji.park@051274803.xyz"),
    ("Pedro Alvarez", "pedro.alvarez@051274803.xyz"),
    ("Aleksandra Janković", "aleksandra.jankovic@051274803.xyz"),
    ("Brian Ndlovu", "brian.ndlovu@051274803.xyz"),
    ("Chiara Bianchi", "chiara.bianchi@051274803.xyz"),
    ("Tomasz Kowalski", "tomasz.kowalski@051274803.xyz"),
    ("Layla Hussein", "layla.hussein@051274803.xyz"),
    ("Katarina Ivić", "katarina.ivic@051274803.xyz"),
    ("Mehdi Bouzid", "mehdi.bouzid@051274803.xyz"),
    ("Aisha Bello", "aisha.bello@051274803.xyz"),
    ("Sebastian Lind", "sebastian.lind@051274803.xyz"),
    ("Jana Džafić", "jana.dzafic@051274803.xyz"),
    ("Rajiv Malhotra", "rajiv.malhotra@051274803.xyz"),
    ("Noemi Toth", "noemi.toth@051274803.xyz"),
    ("Yousef Qassim", "yousef.qassim@051274803.xyz")
]

projects = [
    "AI-powered tutoring assistant",
    "Voice-controlled home automation system",
    "Bias detection in LLMs",
    "Generative music composition tool",
    "AI Ethics curriculum for high school",
    "Explainable AI in healthcare diagnosis",
    "AI-enhanced mental health chatbot",
    "ML for predictive environmental modeling",
    "Open-source NLP framework for under-resourced languages",
    "Synthetic data generation for privacy preservation",
    "AI-based note summarizer for lectures",
    "Smart agriculture monitoring using computer vision",
    "AI chatbot for college admissions help",
    "Detecting misinformation with LLMs",
    "Crowdsourced disaster response prediction using ML",
    "AI-driven language learning buddy",
    "Smart energy consumption optimizer using RL",
    "AI app to assist visually impaired users",
    "Human emotion detection from voice input",
    "Real-time sign language translator with CV and NLP"
]

roles = [
    "Leading architecture and model tuning in NLP pipelines",
    "Designing ethical guidelines for AI in education",
    "Mentoring peers in AI fairness workshops",
    "Building LLM-driven accessibility tools",
    "Driving explainability efforts in neural networks",
    "Contributing to the design of RLHF systems",
    "Organizing open-source AI meetups",
    "Participating in national AI policy drafting groups",
    "Working with NGOs to apply AI in crisis zones",
    "Supporting inclusive AI tool development",
    "Assisting in university AI research groups",
    "Running workshops on generative AI safety",
    "Developing tutorials for responsible AI use",
    "Creating open-source tools for data privacy",
    "Curating datasets for underrepresented languages",
    "Writing blog posts about AI’s social impact",
    "Volunteering for AI4Good hackathons",
    "Helping moderate online AI learning forums",
    "Research assistant on federated learning projects",
    "Advocating responsible AI through student government"
]

learning_goals = [
    "To ensure AI remains equitable and transparent",
    "To push the boundaries of safe general intelligence",
    "To explore AGI alignment techniques responsibly",
    "To build AI for environmental and social good",
    "To advocate for ethical AI policy and inclusion",
    "To prevent misuse of generative models",
    "To create AI that enhances human creativity",
    "To bridge the AI knowledge gap globally",
    "To help guide AI toward humanity’s collective benefit",
    "To avoid dystopian AI futures through collaboration",
    "To make machine learning education more accessible",
    "To develop LLMs that respect human values",
    "To explore AI’s role in global justice and equity",
    "To mentor others in building safe AI tools",
    "To drive diversity and representation in AI datasets",
    "To develop energy-efficient AI solutions",
    "To understand how AI affects labor and economies",
    "To combine AI with neuroscience for good",
    "To create community-focused AI applications",
    "To co-shape the future of human-AI collaboration"
]

faculties = [
    "Faculty of Agriculture",
    "Faculty of Engineering",
    "Faculty of Law",
    "Faculty of Basic Medical Sciences",
    "Faculty of Physical Sciences",
    "Faculty of Social Sciences",
    "Faculty of Management Sciences",
    "Faculty of Arts and Humanities",
    "Faculty of Humanities and Social Sciences",
    "Faculty of Electrical Engineering and Computing",
    "Faculty of Economics and Business",
    "Faculty of Science",
    "Faculty of Food Technology and Biotechnology",
    "Faculty of Agricultural Sciences",
    "Faculty of Teacher Education",
    "Faculty of Civil Engineering",
    "Faculty of Mechanical Engineering and Naval Architecture",
    "Faculty of Mining, Geology and Petroleum Engineering",
    "Faculty of Veterinary Medicine",
    "Academy of Fine Arts",
    "Academy of Music",
    "Academy of Dramatic Art",
    "Faculty of Environmental Design",
    "Faculty of Education",
    "Faculty of Environmental Sciences",
    "Faculty of Chemical Engineering and Technology",
    "Faculty of Graphic Arts",
    "Faculty of Geodesy",
    "Faculty of Forestry",
    "Faculty of Textile Technology",
    "Faculty of Transport and Traffic Sciences",
    "Faculty of Life Sciences",
    "Faculty of Basic Clinical Sciences",
    "Faculty of Allied Medical Sciences",
    "Faculty of Business and Administration",
    "School of Computer Science",
    "School of Medicine",
    "School of Public Health",
    "School of Architecture and Planning",
    "School of Information",
    "School of Data Science",
    "Faculty of Linguistics, Philology and Phonetics",
    "Faculty of Philosophy",
    "Faculty of International Relations",
    "Faculty of Political Science",
    "Faculty of Mathematics and Computer Science",
    "School of Artificial Intelligence",
    "Faculty of Marine Technology",
    "Faculty of Psychology",
    "Faculty of Communication Studies",
    "Faculty of Industrial Design",
    "Faculty of Aerospace Engineering",
    "Faculty of Biomedical Engineering",
    "School of Materials Science",
    "Faculty of Earth and Planetary Sciences",
    "Faculty of Nanotechnology",
    "School of Cybersecurity and Digital Forensics",
    "Faculty of Religious Studies",
    "School of Robotics and Automation",
    "Faculty of Sustainability and Climate Studies"
]


years = ["2026", "2027", "2028", "2029", "2030"]

#for name in names:
for i in range(1):
    driver = webdriver.Chrome(options=options)
    try:

            # Load the website
            driver.get("https://jobs.ashbyhq.com/openai/form/ioi-bolivia-x-open-ai")
            name = random.choice(names)
            project = random.choice(projects)
            role = random.choice(roles)
            learn = random.choice(learning_goals)
            year = random.choice(years)
            school = random.choice(faculties)

            # Wait for the page to load
            time.sleep(2)

            # Fill out a form field
            name_input = driver.find_element(By.NAME, "_systemfield_name")  # Replace with actual name/id/class
            name_input.send_keys(name[0])

            email_input = driver.find_element(By.NAME, "_systemfield_email")  # Replace with actual name/id/class
            email_input.send_keys(name[1])

            #file_input = driver.find_element(By.ID, "_systemfield_resume")  # Replace with actual name
            #file_path = os.path.abspath("234627896.pdf")  # Update path
            #file_input.send_keys(file_path)

            checkbox_label = driver.find_element(By.XPATH, "//label[contains(text(), 'University Student')]")  # Replace with actual ID or selector

            parent = checkbox_label.find_element(By.XPATH, "..")  # Go up to parent

            span = parent.find_element(By.XPATH, ".//span")
            checkbox = span.find_element(By.XPATH, ".//input")  # Get all child elements of the span

            #if not checkbox.is_selected():
            checkbox.click()

            school_input = driver.find_element(By.NAME, "43a14f0b-108c-4178-af24-3a480f25936b")  # Replace with actual name/id/class
            school_input.send_keys(school)


            month_input = driver.find_element(By.CLASS_NAME,
                                               "_input_v5ami_28")  # Replace with actual name/id/class
            month_input.send_keys("January")
            month_input.send_keys(Keys.ENTER)


            year_box_label = driver.find_element(By.XPATH, f"//label[contains(text(), '{year}')]")
            parent = year_box_label.find_element(By.XPATH, "..")  # Go up to parent

            span = parent.find_element(By.XPATH, ".//span")
            year_box = span.find_element(By.XPATH, ".//input")  # Get all child elements of the span
            if not year_box.is_selected():
                year_box.click()

            #booo
            project_input = driver.find_element(By.NAME,
                                               "1fd55710-bba9-4398-8945-f6c52eed6343")  # Replace with actual name/id/class
            project_input.send_keys(project)


            role_input = driver.find_element(By.NAME,
                                                "4a7b771b-0f4a-4385-9ac8-7b49d3055ea2")  # Replace with actual name/id/class
            role_input.send_keys(role)


            learn_input = driver.find_element(By.NAME,
                                                "e23d745e-fae5-4471-ad8a-3e72c4cc878f")  # Replace with actual name/id/class
            learn_input.send_keys(learn)
            # Click the submit button
            submit_btn =  driver.find_element(By.XPATH, "//button[contains(text(), 'Submit')]")  # or By.ID, By.CLASS_NAME, etc.
            print(submit_btn)
            submit_btn.click()

            # Wait for the response
            time.sleep(20)

            print(f"Form submitted successfully: {i} ")

    finally:
        driver.quit()