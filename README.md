COVID\_measures\_CH
================
Robert Pascal Dünner
11/23/2020

## Introduction

These data sets were created to give an overview over the measures to
curb the spread of SARS-CoV-2 that are currently in place in each
canton. There are still some federal measures in place, but cantons are
allowed to put more restrictive measures in place. This is why these
data set are based in the federal measures that are identical across all
cantons. More restrictive measures by canton are then layered on top of
that.

## Data set

The data comes in a few different flavors.

  - The “COVID\_measures\_CH.ods” data set is a spreadsheet that
    contains the federal measures as the first sheet and the measures by
    canton in all subsequent sheets. The first row are the variable
    names.

  - The “COVID\_measures\_CH.csv” data set contains the same data in
    long format. This means that under canton there are 27 levels, one
    for federal regulations and one for each canton.

  - The “COVID\_measures\_CH\_only.csv” data set contains only the
    federal measures in long format.

  - The “COVID\_measures\_KT\_only.csv” data set contains only the
    cantonal measures in long format.

  - The “COVID\_measures\_KT\_epi.csv” data set contains only the
    cantonal measures plus the epidemiological data by canton that is
    available via the [open governement
    data](https://www.zh.ch/de/politik-staat/opendata.html?keyword=ogd#/details/673@fachstelle-ogd-kanton-zuerich)
    from canton Zurich.

## Sources

The timings of measures are assembled from four main scraping sources.
Unfortunately there is no proper official overview, so the sources are
either newspapers, Wikipedia, or handcrafted documents from other people
that were translated to machine readable data here. My main sources
were:

  - [GDK-CDS](https://www.gdk-cds.ch/de/praevention-und-gesundheitsfoerderung/neues-coronavirus):
    Overview created by the conference of the health-directors. By
    canton, and then by date, contains some
    links.

  - [Wikipedia](https://de.wikipedia.org/wiki/COVID-19-Pandemie_in_der_Schweiz#Chronologie_der_Reaktionen_und_Massnahmen):
    Overview by time, with little detail. Often contains links to
    sources, many links are outdated and just point to overview
    pages.

  - [Watson](https://www.watson.ch/schweiz/coronavirus/523168911-neue-corona-regeln-schweiz-diese-massnahmen-gelten-in-deinem-kanton):
    Overview of measures by canton, but shows just current measures and
    the date when they came into action.

  - A document created by Sandra Flückiger of the ETH-Rat communications
    team that details the measures either by canton or federal and some
    international measures as well.

  - The epidemiological data stems from the [open governement
    data](https://www.zh.ch/de/politik-staat/opendata.html?keyword=ogd#/details/673@fachstelle-ogd-kanton-zuerich)
    from canton Zurich, this data set is sometimes also referred to as
    openZH.

## Accuracy

As this data set is curated by hand, it will currently only be updated
irregularly. WARNING: Even though all care was taken to create this data
set, and timings and measures have been verified at the source level of
cantonal ordinances where possible, there are likely to be some
mistakes/or mismatches. We can not guarantee data quality and take no
responsibility whatsoever for any liability coming from the use of this
data. We are of course happy for any inputs if you find alternative
sources to correct dates or measures.

## Variables

Variables are either coded according to the Oxford coronavirus
government response tracker code book, which can be found
[here](https://www.bsg.ox.ac.uk/research/research-projects/coronavirus-government-response-tracker),
or are coded in more detail. Oxford coded variables can be distinguished
by their preceding variable name and oxford (for example C1\_oxford\_).
All other variables have self-explanatory variable names and are coded
as either factors with self-explanatory levels or as numerical.  
The “COVID\_measures\_KT\_epi.csv” data set contains additional variables that are directly imported from the [COVID_19 open government data](https://www.zh.ch/de/politik-staat/opendata.html?keyword=ogd#/details/673@fachstelle-ogd-kanton-zuerich) from canton Zurich. 

Find below a overview table over the non-oxford measures variables. Please refer to the oxford code book linked above for description on the oxford
variables.  

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
