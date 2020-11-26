COVID\_measures\_CH
================
Robert Pascal Dünner
11/23/2020

## Introduction

These data sets were created to track the implementation and relaxation dates of all non-pharmaceutical measures against SARS-CoV-2 in each canton of Switzerland. 

As of November 2020, there are several federally mandated measures in place across the whole of Switzerland. However, cantons are free to implement additional (or more restrictive) measures. Thus the collated data here includes both the federal measures that are identical across all cantons, as well as additional more restrictive measures by canton layered on top of the federal measures.

## Data set

The data is collated and available in several file formats.

  - The “COVID\_measures\_CH.ods” data set is a spreadsheet that
    contains the federal measures as the first sheet and the measures by
    canton in all subsequent sheets. The first row details variable
    names.

  - The “COVID\_measures\_CH.csv” data set contains the same data in
    long format. Variable canton has  27 levels, one
    for federal regulations and one for each canton.

  - The “COVID\_measures\_CH\_only.csv” data set contains only the
    federal measures in long format.

  - The “COVID\_measures\_KT\_only.csv” data set contains only the
    cantonal measures in long format.

  - The “COVID\_measures\_KT\_epi\_openZH.csv” data set contains the
    cantonal measures plus the epidemiological data by canton that is
    available via the [open government
    data](https://www.zh.ch/de/politik-staat/opendata.html?keyword=ogd#/details/673@fachstelle-ogd-kanton-zuerich)
    from canton Zurich.
    
  - The "COVID\_measures\_KT\_epi\_foph.csv" data set contains the
    cantonal measures plus the epidemiological data by canton that is
    available via the [COVID-19 dashboard](https://www.covid19.admin.ch/de/overview) of the federal office for public health.  

## Sources

Implementation and relaxation timings for each measure are assembled from four main sources.
We are unaware of an official overview of measures, thus sources are
either newspapers, Wikipedia, or handcrafted documents from others
that were translated to machine readable data here. Where possible, ordinances from each canton where checked to verify dates. As of 25th November, the main sources are:

  - [GDK-CDS](https://www.gdk-cds.ch/de/praevention-und-gesundheitsfoerderung/neues-coronavirus):
    Overview created by the conference of the health-directors. By
    canton, and then by date, contains some
    links.

  - [Wikipedia](https://de.wikipedia.org/wiki/COVID-19-Pandemie_in_der_Schweiz#Chronologie_der_Reaktionen_und_Massnahmen):
    Overview of measures by time, with little other detail provided. Often contains links to
    sources, many links are outdated and just point to overview
    pages.

  - [Watson](https://www.watson.ch/schweiz/coronavirus/523168911-neue-corona-regeln-schweiz-diese-massnahmen-gelten-in-deinem-kanton):
    Overview of current measures by canton and the date when they came into action. Past dates not available.

  - A document created by Sandra Flückiger of the ETH-Rat communications
    team that details the measures either by canton or federal and some
    international measures as well.

  - The \_openZH epidemiological data stems from the [open government
    data](https://www.zh.ch/de/politik-staat/opendata.html?keyword=ogd#/details/673@fachstelle-ogd-kanton-zuerich)
    from canton Zurich, this data set is sometimes also referred to as
    openZH.
    
  - The \_foph epidemiological data stems from the [COVID-19 dashboard](https://www.covid19.admin.ch/de/overview) of the federal office for public health.  
    
## Accuracy

As this data set is curated by hand, it is shared without guarantee. The data set will be updated
irregularly. 

WARNING: Even though all care was taken to create this data
set, and where possible, timings and measures are verified at source (level of
cantonal ordinances), there are likely to be some
mistakes/or mismatches. We can not guarantee data quality and take no
responsibility whatsoever for any liability as a result of use of this
data. We are of course happy for any inputs if you find alternative
sources to correct dates or measures.

## Variables

Variables are either coded according to the Oxford coronavirus
government response tracker code book, which can be found
[here](https://www.bsg.ox.ac.uk/research/research-projects/coronavirus-government-response-tracker),
or are coded in more detail to reflect measures in Switzerland. Oxford coded variables can be distinguished
by their preceding variable name and oxford (for example C1\_oxford\_). Please refer to the [oxford code book](https://www.bsg.ox.ac.uk/research/research-projects/coronavirus-government-response-tracker) for descriptions on all oxford
variables. All other variables have self-explanatory variable names and are coded
as either factors with self-explanatory levels or as numerical.  
The “COVID\_measures\_KT\_epi_openZH.csv” and the “COVID\_measures\_KT\_epi_foph.csv” data sets contain additional variables that are directly imported from their sources (see above). Those additional epidemiological variables have been renamed with self-explanatory variable names, but their exact coding schemes are unknown to us.  

Below please find an overview table of the non-oxford measures variables.   

| Variable name                        | Description                                                                                                     | Levels / Range                                            | Comment                                                              |
| ------------------------------------ | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------- | -------------------------------------------------------------------- |
| date                                 | This is the date the measure came into action or was communicated                                               |                                                           |                                                                      |
| canton                               | The canton where the measure applies                                                                            | 26 or 27 levels, one for each canton plus one for federal | 27 levels for “COVID\_measures\_CH.csv”, 26 for all other            |
| —                                    | —                                                                                                               | —                                                         | —                                                                    |
| school\_primary\_secondary           | State of obligatory schools                                                                                     | 3 levels: open, closed, open with restrictions            | Complete switch of teaching activity to remote is recorded as closed |
| school\_highschool                   | State of continuing education schools                                                                           | 3 levels: open, closed, open with restrictions            | Complete switch of teaching activity to remote is recorded as closed |
| school\_university                   | State of university level education                                                                             | 3 levels: open, closed, open with restrictions            | Complete switch of teaching activity to remote is recorded as closed |
| —                                    | —                                                                                                               | —                                                         | —                                                                    |
| home\_office\_recommended            | Presence of public campaign for home-office                                                                     | 2 levels: yes / no                                        |                                                                      |
| leisure                              | Are leisure activities open? Museums, zoos, amusement parcs, gaming rooms, casinos and other leisure activities | 3 levels: open, closed, open with restrictions            |                                                                      |
| sport                                | State of private sporting facilities, mainly gyms                                                               | 3 levels: open, closed, open with restrictions            |                                                                      |
| shops                                | State of non-essential shops                                                                                    | 3 levels: open, closed, open with restrictions            |                                                                      |
| hairdressers                         | State of hairdressers                                                                                           | 3 levels: open, closed, open with restrictions            |                                                                      |
| church                               | Religious gatherings permitted?                                                                                 | 3 levels: open, closed, open with restrictions            |                                                                      |
| restaurants                          | Are restaurants open?                                                                                           | 3 levels: open, closed, open with restrictions            |                                                                      |
| restaurants\_tablesize               | Restriction in number of people per table                                                                       | numerical, NA means no restriction                        |                                                                      |
| clubs                                | Are clubs open?                                                                                                 | 3 levels: open, closed, open with restrictions            |                                                                      |
| clubs\_npeople                       | How many people are allowed inside one sector of a club                                                         | numerical, NA means no restriction                        |                                                                      |
| —                                    | —                                                                                                               | —                                                         | —                                                                    |
| facial\_coverings\_shops             | Are facial coverings mandatory in shops                                                                         | 2 levels: yes / no                                        |                                                                      |
| facial\_coverings\_public\_buildings | Are facial coverings mandatory in publicly accessible buildings                                                 | 2 levels: yes / no                                        |                                                                      |
| facial\_coverings\_schools           | Are facial coverings mandatory in schools                                                                       | 2 levels: yes / no                                        |                                                                      |
