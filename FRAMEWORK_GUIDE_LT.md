# Darbas Su Claude Code Starter Framework

> Sis projektas naudoja **Claude Code Starter Framework v4.0.2**.

## Kas Tai Yra

Sis frameworkas nera verslo logikos modulis. Tai darbo organizavimo sluoksnis, skirtas tam, kad AI agentas ir vartotojas galetu tvarkingai vystyti projekta:

- paleisti darbo sesija
- uzbaigti darbo sesija
- islaikyti projekto atminties failus aktualius
- fiksuoti eiga, architektura, sprendimus ir rizikas
- islaikyti vientisa darbo procesa tarp `Codex` ir `Claude`

Trumpai:
- `AGENTS.md` = Codex adapteris
- `CLAUDE.md` = Claude adapteris
- `.claude/` = bendra projekto atmintis
- `src/framework-core/` = bendras Python branduolys

## Pagrindine Ideja

Vartotojas pateikia:
- tikslus
- prioritetus
- verslo sprendimus
- pageidaujamus rezultatus

Agentas yra atsakingas uz:
- technines eigos vedima
- projekto atminties failu prieziura
- aktualios bukles palaikyma
- backlog, roadmap, sprendimu ir riziku fiksavima

Jei projekto atminties failai kertasi su naujesniu vartotojo nurodymu, visada virsenybe turi naujausias vartotojo nurodymas.

## Greita Pradzia

Detali projekto paleidimo ir techninio paruosimo instrukcija:
- `PROJECT_STARTUP_LT.md`

1. Atidaryk projekta terminale.
2. Paleisk pageidaujama agenta:

```bash
# Variantai
codex
claude
```

3. Pokalbyje parasyk:

```text
start
```

4. Baigdamas darbo cikla parasyk:

```text
/fi
```

## Ka Daro `start`

Komanda `start` paleidzia sesijos inicializavima.

Ji:
- patikrina ar nereikia migracijos arba upgrade
- inicializuoja arba sutvarko `.claude/.framework-config`
- patikrina sesijos lock'a
- patikrina ar ankstesne sesija nebuvo nutrukusi
- paleidzia reikalingas pagalbines uzduotis
- uztikrina, kad projekto atminties failai egzistuoja
- ikelia bendra projekto konteksta agentui

Praktine prasme `start` paruosia darbo aplinka taip, kad agentas matytu dabartine projekto bukle.

## Ka Daro `/fi`

Komanda `/fi` paleidzia darbo uzbaigimo cikla.

Ji:
- atnaujina projekto state failus
- paleidzia security ir export uzduotis
- surenka `git status` ir `git diff` informacija
- pazymi sesija kaip tvarkingai uzbaigta
- atlaisvina sesijos lock'a

Praktine prasme tai yra tvarkingas sesijos uzdarymo veiksmas.

## Projekto Atminties Failai

Pagrindiniai failai yra `.claude/` kataloge.

### `SNAPSHOT.md`

Skirtis:
- dabartine projekto bukle
- aktyvus fokusas
- pagrindiniai blokatoriai
- artimiausias rekomenduojamas zingsnis

Naudok kai nori greitai suprasti:
- kur projektas dabar yra
- ka agentas daro siuo metu
- kas ka tik buvo baigta

### `BACKLOG.md`

Skirtis:
- darbai, kuriuos reikia atlikti
- prioritetai
- follow-up punktai

Rekomenduojama struktura:
- `Now`
- `Next`
- `Later`
- `Blocked`

### `ROADMAP.md`

Skirtis:
- stambus etapai
- milestones
- sekantys svarbus projekto lygio zingsniai

Tai neturi buti smulkiu uzduociu sarasas. Roadmap skirtas etapams, ne kasdieniam backlogui.

### `ARCHITECTURE.md`

Skirtis:
- sistemos struktura
- moduliai
- priklausomybes
- duomenu arba request'u srautai
- svarbus architekturiniai apribojimai

Sis failas padeda po savaites ar menesio greitai prisiminti, kaip sistema sudeta.

### `DECISIONS.md`

Skirtis:
- svarbus sprendimai
- kodel jie priimti
- kokios alternatyvos atmestos
- kokios pasekmes laukia toliau

Tipinis irasas:
- data
- statusas
- kontekstas
- sprendimas
- alternatyvos
- pasekmes

### `RISKS.md`

Skirtis:
- aktyvios rizikos
- ju svarba
- mitigacijos
- atsakomybe

Tipiniai riziku tipai:
- produkto
- pristatymo
- architekturos
- saugumo
- operaciniai

### `IDEAS.md`

Skirtis:
- neisipareigotos idejos
- galimos ateities kryptys
- eksperimentu mintys

Sis failas neturetu virsti backlogu.

### `CHANGELOG.md`

Skirtis:
- reiksmingi pakeitimai projekte
- versiju arba releasu lygio pokyciai

## Rezervuoti Framework Failai

Sakniniai framework failai yra rezervuoti pacio frameworko veikimui ir neturetu buti naudojami projekto specifinei informacijai:

- `CLAUDE.md`
- `AGENTS.md`
- `FRAMEWORK_GUIDE.md`
- `FRAMEWORK_GUIDE_LT.md`
- `PROJECT_STARTUP_LT.md`

Tai reiskia:
- projekto nuosava AI instrukcija neturetu buti rasoma i saknini `CLAUDE.md`
- projekto specifiniai uzrasai neturetu buti dedami i `AGENTS.md`
- produkto ar verslo dokumentacija neturetu buti maisoma su framework dokumentacija

Vietoje to rekomenduojama naudoti:
- `.claude/*.md` aktyviai projekto atminciai
- `docs/` produkto ir komandos dokumentacijai
- `README.md` bendram projekto pristatymui ir paleidimui

Rekomenduojama projektines dokumentacijos struktura:
- `README.md` = projekto apzvalga ir paleidimas
- `docs/PRODUCT.md` = produkto tikslai, scope ir verslo kontekstas
- `docs/ARCHITECTURE_NOTES.md` = gilesni techniniai paaiskinimai
- `docs/AI_CONTEXT.md` = papildomas projekto kontekstas agentui, jei reikia

Sie `docs/` failai yra rekomenduojamo startinio komplekto dalis ir gali buti sugeneruojami kaip pradine projekto dokumentacija.

Rekomenduojama auksto lygio katalogu struktura:

```text
Projektas/
  CLAUDE.md
  AGENTS.md
  README.md
  CHANGELOG.md
  FRAMEWORK_GUIDE.md
  FRAMEWORK_GUIDE_LT.md
  PROJECT_STARTUP_LT.md
  .claude/
  .codex/
  docs/
  src/
  security/
```

## Atsakomybiu Modelis

Teisinga darbo tvarka yra tokia:

- vartotojas neraso kiekvieno state failo ranka
- agentas priziuri technine atminties dali
- vartotojas koreguoja tikslus, prioritetus ir verslo krypti

Tai reiskia:
- tu rasai uzduotis ir krypti pokalbyje
- agentas atnaujina `SNAPSHOT`, `BACKLOG`, `ROADMAP`, `ARCHITECTURE`, `DECISIONS`, `RISKS`

## Kada Koki Faila Atnaujinti

### Kada atnaujinti `SNAPSHOT.md`

- po reiksmingo uzbaigto darbo
- pasikeitus aktyviam fokusui
- atsiradus naujam blokatoriui
- pries baigiant sesija

### Kada atnaujinti `BACKLOG.md`

- kai keiciasi prioritetai
- kai atsiranda nauju darbu
- kai uzduotis tampa `blocked`
- kai darbai baigiami ir reikia perstumti eiliskuma

### Kada atnaujinti `ROADMAP.md`

- kai susitariama del etapu
- kai keiciasi milestones
- kai uzbaigiamas stambus etapas

### Kada atnaujinti `ARCHITECTURE.md`

- kai keiciasi moduliu struktura
- kai atsiranda nauja svarbi integracija
- kai pakeiciamas duomenu arba request'u srautas
- kai priimamas reiksmingas techninis sprendimas

### Kada atnaujinti `DECISIONS.md`

- kai priimamas svarbus techninis ar produkto sprendimas
- kai atmetama alternatyva
- kai sprendimas veliau pakeiciamas

### Kada atnaujinti `RISKS.md`

- kai aptinkama nauja rizika
- kai padideja rizikos svarba
- kai numatoma mitigacija
- kai rizika uzdaroma arba tampa nebeaktuali

## Rekomenduojamas Darbo Ritmas

Labai praktiskas darbo ciklas:

1. `start`
2. Agentas perskaito dabartine atminti
3. Atliekamas darbas
4. Agentas atnaujina state failus
5. Jei reikia, daromas commit
6. `/fi`

Jei projektas vyksta rimtai, verta laikytis tokios taisykles:
- kiekvienas reiksmingas pakeitimas turi atsispindeti bent viename is state failu
- kiekvienas architekturos sprendimas turi patekti i `DECISIONS.md`
- kiekviena aktyvi reiksminga rizika turi patekti i `RISKS.md`

## Pagrindiniai Keliai

```text
AGENTS.md                          # Codex adapteris
CLAUDE.md                          # Claude adapteris
FRAMEWORK_GUIDE.md                 # Trumpas anglu kalbos gidas
FRAMEWORK_GUIDE_LT.md              # Isamus lietuviskas gidas
PROJECT_STARTUP_LT.md              # Projekto paleidimas ir techninis paruosimas
.claude/SNAPSHOT.md                # Dabartine bukle
.claude/BACKLOG.md                 # Darbai ir prioritetai
.claude/ROADMAP.md                 # Etapai ir milestones
.claude/ARCHITECTURE.md            # Sistemos struktura
.claude/DECISIONS.md               # Sprendimu zurnalas
.claude/RISKS.md                   # Riziku registras
.claude/IDEAS.md                   # Idejos
src/framework-core/main.py         # Python entry point
src/framework-core/tasks/config.py # Baseline ir state failu generavimas
security/                          # Security scenarijai
```

## Ka Agentas Turi Daryti Realioje Praktikoje

Jei agentas dirba teisingai, jis turetu:
- sesijos pradzioje perskaityti pagrindinius state failus
- darbo metu ne tik rasyti koda, bet ir islaikyti konteksta aktualu
- pabaigoje atnaujinti bent `SNAPSHOT.md` ir `BACKLOG.md`
- esant reiksmingam pokyciui atnaujinti `ROADMAP.md`, `ARCHITECTURE.md`, `DECISIONS.md`, `RISKS.md`

Jei agentas to nedaro, po keliu sesiju projektas pradeda isbyreti konteksto prasme.

## Ko Nereikia Daryti

- nelaikyti visos eigos tik pokalbiuose
- nenaudoti `BACKLOG.md` kaip chaotisko minciu saraso
- nenaudoti `ROADMAP.md` smulkioms uzduotims
- nelaikyti architekturiniu sprendimu tik galvoje
- nepalikti aktyviu riziku nefiksuotu

## Praktinis Minimumas

Jei nori minimalios, bet teisingos tvarkos, uztenka laikytis siu taisykliu:

- `SNAPSHOT.md` visada turi rodyti dabartine bukle
- `BACKLOG.md` visada turi rodyti ka daryti toliau
- `ROADMAP.md` visada turi rodyti stambius etapus
- `ARCHITECTURE.md` visada turi atitikti faktine sistema
- `DECISIONS.md` turi fiksuoti svarbius pasirinkimus
- `RISKS.md` turi rodyti kas kelia gresme terminams, kokybei ar saugumui

## Jei Nori Dar Grieztesnes Tvarkos

Galima papildomai susitarti, kad agentas:
- po kiekvienos didesnes uzduoties atnaujina `SNAPSHOT.md`
- po kiekvieno prioriteto pokycio atnaujina `BACKLOG.md`
- po kiekvieno architekturinio sprendimo pildo `DECISIONS.md`
- po kiekvienos naujos gresmes pildo `RISKS.md`
- pries commit patikrina ar state failai atitinka realia bukle

Tai jau beveik pilnas darbo valdymo sluoksnis, ne tik paprastas dokumentu rinkinys.

## Isvada

Sis frameworkas geriausiai veikia tada, kai i ji ziurima ne kaip i dar viena dokumentacija, o kaip i projekto atminties ir darbo disciplinos sistema.

Teisingas modelis yra toks:
- tu duodi krypti
- agentas veda technine eiga
- state failai tampa ilgalaike projekto atmintimi
- kiekviena sesija palieka tvarkinga, suprantama ir testina projekto bukle
