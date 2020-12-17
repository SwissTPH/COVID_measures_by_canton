COVID\_measures\_CH
================
Robert Pascal Dünner
12/17/2020

## Introduction

These data sets were created to track the implementation and relaxation dates of all non-pharmaceutical measures against SARS-CoV-2 in each canton of Switzerland. 

As of November 2020, there are several federally mandated measures in place across the whole of Switzerland. However, cantons are free to implement additional (or more restrictive) measures. Thus the collated data here includes both the federal measures that are identical across all cantons, as well as additional more restrictive measures by canton layered on top of the federal measures.  
As of beginning of December a lot of new measures, both federal and cantonal, have been implemented that concern the opening hours of businesses, restaurants etc. Those measures are only very badly represented in this data set, as it does not track opening hours. 

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
    It also contains the maximum daily temperature for 16 cantons that is available from [MeteoSchweiz](https://www.meteoschweiz.admin.ch/home.html?tab=overview) via [opendata.swiss]("https://data.geo.admin.ch/ch.meteoschweiz.klima/nbcn-tageswerte/liste-download-nbcn-d.csv").

## Sources    
The timings of implementation and relaxation of cantonal measures have been collected from several different sources and translated to machine readable form here. Where possible, ordinances from each canton where checked to verify dates. Find below a list of current sources.

  - [GDK-CDS](https://www.gdk-cds.ch/de/praevention-und-gesundheitsfoerderung/neues-coronavirus):
    Overview created by the conference of the health-directors. By
    canton, and then by date, contains some
    links. No explicit mention of a license.

  - [Wikipedia](https://de.wikipedia.org/wiki/COVID-19-Pandemie_in_der_Schweiz#Chronologie_der_Reaktionen_und_Massnahmen):
    Overview of measures by time, with little other detail provided. Often contains links to
    sources, many links are outdated and just point to overview
    pages. Wikipedia is licensed under a [CC BY-SA-3.0 license](https://creativecommons.org/licenses/by-sa/3.0/).

  - [Watson](https://www.watson.ch/schweiz/coronavirus/523168911-neue-corona-regeln-schweiz-diese-massnahmen-gelten-in-deinem-kanton):
    Overview of current measures by canton and the date when they came into action. Past dates not available. No explicit mention of a license.

  - A document created by Sandra Flückiger of the ETH-Rat communications
    team that details the measures either by canton or federal and some
    international measures as well. Usage granted.

  - The \_openZH epidemiological data stems from the [open government
    data](https://www.zh.ch/de/politik-staat/opendata.html?keyword=ogd#/details/673@fachstelle-ogd-kanton-zuerich)
    from canton Zurich, which is distributed under a [CC BY-4.0 license](https://creativecommons.org/licenses/by/4.0/). This data set is sometimes colloquially referred to as
    openZH.  
    
  - The temperature data stems from [MeteoSchweiz](https://www.meteoschweiz.admin.ch/home.html?tab=overview) via [opendata.swiss]("https://data.geo.admin.ch/ch.meteoschweiz.klima/nbcn-tageswerte/liste-download-nbcn-d.csv"). It is published under copyright licence by the Swiss federal authorities and granted non-comercial use and distribution under mention of the source.

## License
As different sources with different licenses were used, we believe that a [CC BY-SA-4.0 license](https://creativecommons.org/licenses/by-sa/4.0/) is applicable to this work. The original work remains of course under its original license.  

## Accuracy
As this data set is curated by hand, it is shared without guarantee. The data set will be updated
irregularly. 

WARNING: Even though all care was taken to create this data
set, and where possible, timings and measures are verified at source (level of
cantonal ordinances), there are likely to be some
mistakes/or mismatches. No guarantee for data quality is given and no
responsibility whatsoever for any liability as a result of use of this
data is taken. If you have alternative sources, would like to correct dates or measures or have any other type of input please get in touch with us.

## Variables
Variables are either coded according to the Oxford coronavirus
government response tracker code book, which can be found
[here](https://www.bsg.ox.ac.uk/research/research-projects/coronavirus-government-response-tracker),
or are coded in more detail to reflect measures in Switzerland. Oxford coded variables can be distinguished
by their preceding variable name or oxford (for example C1\_oxford\_ or oxford\_containment\_health). Please refer to the [oxford code book](https://www.bsg.ox.ac.uk/research/research-projects/coronavirus-government-response-tracker) for descriptions on all oxford
variables. All other variables have self-explanatory variable names and are coded
as either factors with self-explanatory levels or as numerical.  
The “COVID\_measures\_KT\_epi_openZH.csv” data set contains additional variables that are directly imported from their source (see above). Those additional epidemiological variables have been renamed with self-explanatory variable names, but their exact coding schemes are unknown to us.  

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
