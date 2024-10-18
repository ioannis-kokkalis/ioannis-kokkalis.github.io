---
title: 'Learning Hugo (Go-based Static Site Generator)'
date: 2024-10-18
---

To Do next:
- [X] just start writing stuff
- [X] clear the other links too and keep the useful ones (and from chatgpt)
- [ ] make a github actions that will build and publish this
- [ ] keep the project on the side to continue at least after thesis
- [ ] understand content-structure, like which named filess map to which layouts etc
- [ ] make home page multilingual and create a basic blog link for the posts (if css, work with grids)
- [ ] taxonomies for cv, each directory one category, find a way to brink all in one page tho (prob at _index.md)

# The Search

Starting with the [official documentation](https://gohugo.io/getting-started/).

Following the external sources, the more [basic one](https://cloudcannon.com/tutorials/hugo-beginner-tutorial/) and the more [advanced one](https://www.giraffeacademy.com/static-site-generators/hugo/).

And another one that seemed all over the place but works as [an example](https://draft.dev/learn/creating-hugo-themes). Mostly its about multi-author support for posts.

Something about [_index and index](https://akrabat.com/index-md-vs-_index-md-in-hugo/) in content.

## Multiple Languages

**i18n** instead of the word it represents *internationalization*, and in general non-homophone numeronyms, should be illegal.

Start with [this video](https://www.youtube.com/watch?v=Uk7XbbX-3I8) then maybe check this [solid start](https://staticmania.com/blog/how-to-set-up-a-multilingual-website-in-hugo#top).

Definately check [this](https://discourse.gohugo.io/t/passing-a-custom-variable-to-i18n/43995) for passing paramters to i18n identifiers-functions(?).

Some ChatGPT experimentation to get an early idea.

```
with hugo, i want to create a page that i will list out my cv entries, each entry will contain a title, a datestart-dateend (as text), a description as HTML, and a list of items that each item is a string and a number 0.0-1.0, how would you do that?
ChatGPT said:
ChatGPT
To create a page in Hugo that lists your CV entries with a title, date range, description (HTML), and a list of items where each item is a string with a value between 0.0–1.0, follow these steps:

1. Define the Content Structure in Front Matter
Create a new content file for your CV page (e.g., cv.md).

In the front matter of the file, define your CV entries using Hugo's YAML, TOML, or JSON format. Here’s an example in YAML:

yaml
Copy code
---
title: "My CV"
entries:
  - title: "Job Title 1"
    date_start: "January 2020"
    date_end: "December 2022"
    description: "<p>Detailed job description in HTML.</p>"
    items:
      - name: "Skill 1"
        proficiency: 0.9
      - name: "Skill 2"
        proficiency: 0.7
  - title: "Job Title 2"
    date_start: "March 2018"
    date_end: "December 2019"
    description: "<p>Another detailed job description in HTML.</p>"
    items:
      - name: "Skill 3"
        proficiency: 0.8
      - name: "Skill 4"
        proficiency: 0.6
---

2. Create a Template to Render CV Entries
Next, you’ll need a template to display these entries. Create or edit a template file (e.g., layouts/_default/single.html) that will loop through and render the entries.

Here’s an example template that renders each CV entry:

html
Copy code
<article>
    <h1>{{ .Title }}</h1>
    
    {{ range .Params.entries }}
    <section>
        <h2>{{ .title }}</h2>
        <p>{{ .date_start }} - {{ .date_end }}</p>
        <div>{{ .description | safeHTML }}</div>
        
        <ul>
            {{ range .items }}
            <li>
                <span>{{ .name }}:</span>
                <span>{{ printf "%.1f" .proficiency }}</span>
            </li>
            {{ end }}
        </ul>
    </section>
    {{ end }}
</article>
3. Explanation of the Code
Front Matter: In the cv.md file, each entry contains a title, start/end dates, an HTML description, and a list of items with name and proficiency values (0.0–1.0).
Template:
The {{ .Title }} displays the page title.
The {{ range .Params.entries }} loops through each entry in the entries list.
{{ .description | safeHTML }} renders the description as HTML.
The {{ range .items }} loops through each items list for an entry and displays the skill name and its proficiency value.
4. Usage
Add this template to your Hugo site and use it in a content file like content/cv.md. The list will render your CV entries formatted according to the provided structure.

This setup lets you easily manage your CV data and style it using the Hugo templating system.






You said:
i also want to have for each entry the same content but in different languages, one in english and one in greek
ChatGPT said:
ChatGPT
To handle multilingual content for each CV entry in Hugo, you can utilize Hugo’s built-in multilingual functionality. Hugo allows you to specify different versions of content in multiple languages by creating separate content files or by adding localized content directly in the front matter.

Approach 1: Using Language-Specific Content Files
This approach involves creating two versions of your CV page: one in English (en) and one in Greek (gr). Here's how to set it up:

1. Configure Languages in config.toml
In your Hugo site configuration file (config.toml), define the languages for the site:

toml
Copy code
defaultContentLanguage = "en"
[languages]
[languages.en]
  weight = 1
  languageName = "English"
  contentDir = "content/en"
  
[languages.gr]
  weight = 2
  languageName = "Greek"
  contentDir = "content/gr"
This configuration sets up two languages, English and Greek, and points to different content directories for each language.

2. Create Content for Each Language
In the content directory, create subdirectories for each language (e.g., en and gr), and create a cv.md file in each:

content/en/cv.md (English version):
yaml
Copy code
---
title: "My CV"
entries:
  - title: "Job Title 1"
    date_start: "January 2020"
    date_end: "December 2022"
    description: "<p>Detailed job description in English.</p>"
    items:
      - name: "Skill 1"
        proficiency: 0.9
      - name: "Skill 2"
        proficiency: 0.7
  - title: "Job Title 2"
    date_start: "March 2018"
    date_end: "December 2019"
    description: "<p>Another detailed job description in English.</p>"
    items:
      - name: "Skill 3"
        proficiency: 0.8
      - name: "Skill 4"
        proficiency: 0.6
---
content/gr/cv.md (Greek version):
yaml
Copy code
---
title: "Το Βιογραφικό Μου"
entries:
  - title: "Τίτλος Εργασίας 1"
    date_start: "Ιανουάριος 2020"
    date_end: "Δεκέμβριος 2022"
    description: "<p>Λεπτομερής περιγραφή εργασίας στα Ελληνικά.</p>"
    items:
      - name: "Δεξιότητα 1"
        proficiency: 0.9
      - name: "Δεξιότητα 2"
        proficiency: 0.7
  - title: "Τίτλος Εργασίας 2"
    date_start: "Μάρτιος 2018"
    date_end: "Δεκέμβριος 2019"
    description: "<p>Άλλη λεπτομερής περιγραφή εργασίας στα Ελληνικά.</p>"
    items:
      - name: "Δεξιότητα 3"
        proficiency: 0.8
      - name: "Δεξιότητα 4"
        proficiency: 0.6
---
3. Update the Template
The template you created earlier remains the same because Hugo will automatically switch the content based on the language. Just make sure you include language links if you want to allow users to switch between the English and Greek versions of the page.

Here’s an example of adding language links in the template:

html
Copy code
<nav>
    <ul>
        <li><a href="{{ .LangURL "cv.md" }}" lang="en">English</a></li>
        <li><a href="{{ .LangURL "cv.md" }}" lang="gr">Ελληνικά</a></li>
    </ul>
</nav>

<article>
    <h1>{{ .Title }}</h1>
    
    {{ range .Params.entries }}
    <section>
        <h2>{{ .title }}</h2>
        <p>{{ .date_start }} - {{ .date_end }}</p>
        <div>{{ .description | safeHTML }}</div>
        
        <ul>
            {{ range .items }}
            <li>
                <span>{{ .name }}:</span>
                <span>{{ printf "%.1f" .proficiency }}</span>
            </li>
            {{ end }}
        </ul>
    </section>
    {{ end }}
</article>
Approach 2: Using Multilingual Front Matter in a Single File
Another option is to store both English and Greek content in the same file and switch between them based on the site’s active language. Here's how to do it:

1. Front Matter with Language Fields
In this approach, you add the English and Greek versions of your content to the same cv.md file using language-specific keys in the front matter:

yaml
Copy code
---
title:
  en: "My CV"
  gr: "Το Βιογραφικό Μου"

entries:
  - title:
      en: "Job Title 1"
      gr: "Τίτλος Εργασίας 1"
    date_start: "January 2020"
    date_end: "December 2022"
    description:
      en: "<p>Detailed job description in English.</p>"
      gr: "<p>Λεπτομερής περιγραφή εργασίας στα Ελληνικά.</p>"
    items:
      - name:
          en: "Skill 1"
          gr: "Δεξιότητα 1"
        proficiency: 0.9
      - name:
          en: "Skill 2"
          gr: "Δεξιότητα 2"
        proficiency: 0.7
---

2. Update Template for Language Selection
Modify the template to render the content based on the current language:

html
Copy code
<article>
    <h1>{{ index .Title .Lang }}</h1>
    
    {{ range .Params.entries }}
    <section>
        <h2>{{ index .title .Lang }}</h2>
        <p>{{ .date_start }} - {{ .date_end }}</p>
        <div>{{ index .description .Lang | safeHTML }}</div>
        
        <ul>
            {{ range .items }}
            <li>
                <span>{{ index .name .Lang }}:</span>
                <span>{{ printf "%.1f" .proficiency }}</span>
            </li>
            {{ end }}
        </ul>
    </section>
    {{ end }}
</article>
In this setup:

{{ index .title .Lang }} selects the correct language version of the title.
The same applies to other multilingual fields like description and name.
Conclusion
Approach 1: Use separate language files (content/en/cv.md and content/gr/cv.md) for each language.
Approach 2: Store both English and Greek content in the same file, using Hugo's index function to switch based on the active language.
Both approaches allow you to serve a multilingual CV using Hugo’s features. The first approach is easier to manage if you have many translations and complex content, while the second approach keeps all translations in one file for easier editing.






You said:
can we use isntead of content/gr/ and content/en, cv.en.md and cv.gr.md?
ChatGPT said:
ChatGPT
Yes, you can use the filename format cv.en.md and cv.gr.md instead of creating separate language-specific directories (content/en/ and content/gr/). This method uses Hugo's filename-based language support and is simpler for smaller multilingual sites.

Here’s how you can set it up:

1. Configure Languages in config.toml
First, configure Hugo to recognize the languages in your config.toml:

toml
Copy code
defaultContentLanguage = "en"

[languages]
[languages.en]
  languageName = "English"
  weight = 1

[languages.gr]
  languageName = "Greek"
  weight = 2
This defines the two languages, English (en) and Greek (gr).

2. Create Language-Specific Content Files
Next, you create language-specific versions of your CV page by adding language codes to the filenames.

English version: content/cv.en.md
Greek version: content/cv.gr.md
Each file contains content for the respective language. For example:

content/cv.en.md (English):
yaml
Copy code
---
title: "My CV"
entries:
  - title: "Job Title 1"
    date_start: "January 2020"
    date_end: "December 2022"
    description: "<p>Detailed job description in English.</p>"
    items:
      - name: "Skill 1"
        proficiency: 0.9
      - name: "Skill 2"
        proficiency: 0.7
  - title: "Job Title 2"
    date_start: "March 2018"
    date_end: "December 2019"
    description: "<p>Another detailed job description in English.</p>"
    items:
      - name: "Skill 3"
        proficiency: 0.8
      - name: "Skill 4"
        proficiency: 0.6
---
content/cv.gr.md (Greek):
yaml
Copy code
---
title: "Το Βιογραφικό Μου"
entries:
  - title: "Τίτλος Εργασίας 1"
    date_start: "Ιανουάριος 2020"
    date_end: "Δεκέμβριος 2022"
    description: "<p>Λεπτομερής περιγραφή εργασίας στα Ελληνικά.</p>"
    items:
      - name: "Δεξιότητα 1"
        proficiency: 0.9
      - name: "Δεξιότητα 2"
        proficiency: 0.7
  - title: "Τίτλος Εργασίας 2"
    date_start: "Μάρτιος 2018"
    date_end: "Δεκέμβριος 2019"
    description: "<p>Άλλη λεπτομερής περιγραφή εργασίας στα Ελληνικά.</p>"
    items:
      - name: "Δεξιότητα 3"
        proficiency: 0.8
      - name: "Δεξιότητα 4"
        proficiency: 0.6
---
3. Update Template (Optional: Language Links)
In your template (e.g., layouts/_default/single.html), Hugo automatically serves the correct language version based on the URL or the language settings in the browser.

However, you can also add links to switch between the English and Greek versions of the page using Hugo’s relLangURL function:

html
Copy code
<nav>
    <ul>
        <li><a href="{{ .RelPermalink | relLangURL "en" }}">English</a></li>
        <li><a href="{{ .RelPermalink | relLangURL "gr" }}">Ελληνικά</a></li>
    </ul>
</nav>

<article>
    <h1>{{ .Title }}</h1>
    
    {{ range .Params.entries }}
    <section>
        <h2>{{ .title }}</h2>
        <p>{{ .date_start }} - {{ .date_end }}</p>
        <div>{{ .description | safeHTML }}</div>
        
        <ul>
            {{ range .items }}
            <li>
                <span>{{ .name }}:</span>
                <span>{{ printf "%.1f" .proficiency }}</span>
            </li>
            {{ end }}
        </ul>
    </section>
    {{ end }}
</article>
4. URL Structure
With this setup, Hugo will automatically generate the URLs for different languages:

English version: /cv/
Greek version: /gr/cv/
Users can switch between languages by using the language-specific URLs or using the links provided in the template.

Conclusion
By using cv.en.md and cv.gr.md, Hugo will automatically detect and serve the appropriate language content without needing separate language directories. It’s a simple and effective way to handle multilingual content for a page like a CV.






You said:
can i also rank the entries with something like weight? so i write them chronologically in file but when the .entries retrieves them, the order will be as weighted
ChatGPT said:
ChatGPT
Yes, you can use a weight parameter in Hugo to control the order of your entries. Hugo supports a weight field for sorting content, and you can apply this concept to individual CV entries within the front matter as well.

Here’s how to implement it:

1. Add a weight Field to Each Entry
In your cv.en.md and cv.gr.md files (or any multilingual setup), add a weight field to each entry. Entries with lower weights will be displayed first, while higher weights will be displayed later.

For example, in your cv.en.md file, it might look like this:

yaml
Copy code
---
title: "My CV"
entries:
  - title: "Job Title 1"
    date_start: "January 2020"
    date_end: "December 2022"
    description: "<p>Detailed job description in English.</p>"
    weight: 2
    items:
      - name: "Skill 1"
        proficiency: 0.9
      - name: "Skill 2"
        proficiency: 0.7
  - title: "Job Title 2"
    date_start: "March 2018"
    date_end: "December 2019"
    description: "<p>Another detailed job description in English.</p>"
    weight: 1
    items:
      - name: "Skill 3"
        proficiency: 0.8
      - name: "Skill 4"
        proficiency: 0.6
---
In this example:

"Job Title 1" has a weight of 2.
"Job Title 2" has a weight of 1 (so it will appear first).
You can add a similar structure to cv.gr.md for Greek translations.

2. Update the Template to Sort Entries by Weight
In your Hugo template (e.g., layouts/_default/single.html), you can modify the range function to sort the entries by their weight field.

Here’s an updated version of your template:

html
Copy code
<article>
    <h1>{{ .Title }}</h1>
    
    {{ range sort .Params.entries "weight" }}
    <section>
        <h2>{{ .title }}</h2>
        <p>{{ .date_start }} - {{ .date_end }}</p>
        <div>{{ .description | safeHTML }}</div>
        
        <ul>
            {{ range .items }}
            <li>
                <span>{{ .name }}:</span>
                <span>{{ printf "%.1f" .proficiency }}</span>
            </li>
            {{ end }}
        </ul>
    </section>
    {{ end }}
</article>
3. How the Sorting Works
{{ range sort .Params.entries "weight" }}: This line ensures that Hugo sorts the entries by the weight field in ascending order.
Entries with a lower weight appear first.
If two entries have the same weight, they will appear in the order they are listed in the file.
Summary
Add weight: Add a weight field to each entry in the front matter.
Sort in Template: Use Hugo's sort function to order the entries by weight when rendering.
This way, you can list the entries in the file chronologically but control their display order using the weight field in Hugo.






You said:
so the sort happens by my code not by hugo itself, so i can name it rank instead of weight right?
ChatGPT said:
ChatGPT
Yes, you're correct! The sorting is controlled by your template code, not Hugo’s internal mechanism, so you can name the field whatever you prefer, such as rank instead of weight.

Here’s how to implement it:

1. Rename weight to rank
In your content files (cv.en.md, cv.gr.md), you can rename the weight field to rank. For example:

yaml
Copy code
---
title: "My CV"
entries:
  - title: "Job Title 1"
    date_start: "January 2020"
    date_end: "December 2022"
    description: "<p>Detailed job description in English.</p>"
    rank: 2
    items:
      - name: "Skill 1"
        proficiency: 0.9
      - name: "Skill 2"
        proficiency: 0.7
  - title: "Job Title 2"
    date_start: "March 2018"
    date_end: "December 2019"
    description: "<p>Another detailed job description in English.</p>"
    rank: 1
    items:
      - name: "Skill 3"
        proficiency: 0.8
      - name: "Skill 4"
        proficiency: 0.6
---
2. Update the Template to Sort by rank
You’ll need to modify the template to sort by rank instead of weight:

html
Copy code
<article>
    <h1>{{ .Title }}</h1>
    
    {{ range sort .Params.entries "rank" }}
    <section>
        <h2>{{ .title }}</h2>
        <p>{{ .date_start }} - {{ .date_end }}</p>
        <div>{{ .description | safeHTML }}</div>
        
        <ul>
            {{ range .items }}
            <li>
                <span>{{ .name }}:</span>
                <span>{{ printf "%.1f" .proficiency }}</span>
            </li>
            {{ end }}
        </ul>
    </section>
    {{ end }}
</article>
How It Works:
In the front matter, you use rank to order your entries.
In the template, {{ range sort .Params.entries "rank" }} sorts the entries based on the rank field.
Summary
Yes, you can use rank (or any other name) instead of weight, and the sorting will work the same way. The sorting logic is entirely up to you since you're handling it with the sort function in your template.
```

## Misc

`.Scratch` is a key-value store for temporary pairs to use inside Go-templates.

# Alternatives to Hugo

I did consider other options before accepting Hugo for the ride:
- ~manually: write php and request each page, then save the page to the output directory~
- Jekyll (Ruby-based): plugins are great only when they move along side the main project, and not when left behind
- Next.js (JavaScript/React-based): I want to reserve JS heavy solutions for other projects that actually need it
	- Similarly I wanted to avoid PHP heavy solutions like Laravel with Jigsaw and Sculpin.
