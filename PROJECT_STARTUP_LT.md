# Projekto Paleidimas Ir Techninis Paruosimas

## Paskirtis

Sis dokumentas apraso, kaip teisingai pradeti nauja projekta su siuo frameworku:
- kokia seka atlikti veiksmus
- ka susikurti pirmiausia
- kada ideti frameworka
- ka turi padaryti agentas
- kokie failai turi atsirasti po paleidimo

Tikslas yra ne tik uzkurti projekta, bet iskart tureti:
- tvarkinga technine baze
- aisku darbo procesa
- islaikoma projekto atminti
- suprantama projekto eiga nuo pirmos dienos

## Rekomenduojama Seka

Teisingiausia praktine seka dazniausiai yra tokia:

1. susikurti projekto aplanka
2. inicializuoti technologini pagrinda
3. inicializuoti `git`
4. ideti frameworka i projekto sakni
5. paleisti agenta
6. paleisti `start`
7. atlikti pirma prasminga projekto formavimo cikla

Trumpai:
- pirma projektas
- po to frameworkas

Tokia seka geriausia todel, kad frameworkas gali analizuoti jau egzistuojancia projekto struktura, stacka ir failus.

## 1 Etapas - Projekto Katalogo Sukurimas

Sukuriamas pagrindinis projekto aplankas.

Pavyzdys:

```text
ManoProjektas/
```

Svarbu:
- projekto pavadinimas turetu buti aiskus
- frameworkas veliau naudos si pavadinima state failuose

## 2 Etapas - Technologinio Pagrindo Inicializavimas

Pries dedant frameworka rekomenduojama, kad projekto papkeje jau butu bent minimalus realus technologinis pagrindas.

Svarbu:
- cia kalbama apie konkretaus projekto failus ir katalogus, o ne apie `VS Code` diegima
- tai gali buti ranka sukurti baziniai failai
- arba automatiskai sugeneruotas projekto karkasas pasirinktu irankiu

Praktikoje sias komandas dazniausiai gali paleisti agentas.
Tau nereikia ju vykdyti ranka kiekvienam projektui, nebent:
- nori pats kontroliuoti kiekviena zingsni
- reikia tavo pasirinkimo tarp keliu variantu
- reikia papildomo leidimo vykdyti tam tikras komandas

Pavyzdziai:

### Node.js projektui

```bash
npm init -y
```

### Python projektui

Galimi variantai, pvz.:

```bash
py -m venv .venv
```

ir papildomai pagal projekta:

```bash
pip freeze > requirements.txt
```

Arba galima naudoti `pyproject.toml`, jei projektas valdomas tuo budu.

### Frontend projektui

Galima iskart generuoti karkasa, pvz. per `vite`, `next`, ar kita pasirinkta iranki.

## Minimalus Techninis Startas

Net jei projektas dar tuscias, verta tureti bent:

```text
README.md
.gitignore
src/
```

Papildomai pagal pasirinkta stacka gali atsirasti:
- `package.json`
- `requirements.txt`
- `pyproject.toml`
- `tsconfig.json`
- `vite.config.*`
- `next.config.*`

Kodel tai svarbu:
- frameworkas tada mato realesni projekto pagrinda
- gali tiksliau sugeneruoti `ARCHITECTURE.md`, `SNAPSHOT.md`, `BACKLOG.md`
- mazesne tikimybe, kad state failai bus is oro

## 3 Etapas - Git Inicializavimas

Rekomenduojama iskart inicializuoti repozitorija:

```bash
git init
```

Nauda:
- frameworkas gali sekti pakeitimus
- veikia sesijos uzbaigimo `git` patikros
- lengviau valdyti etapus ir commitus

Jei yra galimybe, verta iskart susikurti ir pirma branch logika:
- `master` arba `main`
- veliau darbines branch strategijos pagal poreiki

## 4 Etapas - Frameworko Idejimas

Kai jau yra bazinis projektas, i to projekto sakni idedamas sis frameworkas.

Po idejimo paprastai projekte atsiranda:
- `AGENTS.md`
- `CLAUDE.md`
- `FRAMEWORK_GUIDE.md`
- `FRAMEWORK_GUIDE_LT.md`
- `.claude/`
- `.codex/`
- `src/framework-core/`
- `security/`

Frameworkas turi buti projekto saknyje, nes jis dirba su to pacio projekto failais ir atmintimi.

Svarbi taisykle:
- `CLAUDE.md` ir `AGENTS.md` saknyje yra frameworko valdymo failai
- jie neturi buti naudojami kaip projekto laisvi uzrasai ar produkto dokumentacija
- projekto specifine informacija turi keliauti i `.claude/*.md`, `docs/` arba `README.md`

Profesionaliausia praktika:
- frameworko failai valdo agento darba
- `.claude/*.md` saugo aktyvia projekto atminti
- `docs/` saugo ilgalaike produkto ir technine dokumentacija

Rekomenduojamas startinis `docs/` komplektas:
- `docs/PRODUCT.md`
- `docs/ARCHITECTURE_NOTES.md`
- `docs/AI_CONTEXT.md`

## 5 Etapas - Pirmas Paleidimas

Atidaromas terminalas projekto saknyje ir paleidziamas agentas:

```bash
codex
```

arba:

```bash
claude
```

Tada pokalbyje rasoma:

```text
start
```

## Kas Vyksta Paleidus `start`

`start` nera tik komanda pradeti darba. Ji paleidzia technini sesijos inicializavimo procesa.

Per `start` frameworkas:
- sutvarko konfiguracija
- patikrina sesijos lock'a
- patikrina ar nebuvo nutrukusi ankstesne sesija
- paleidzia pagalbinius taskus
- uztikrina, kad projekto atminties failai egzistuoja
- paruosia bendra konteksta agentui

Tai svarbu todel, kad agentas pradetu darba ne nuo nulio, o su aktualia projekto bukle.

## 6 Etapas - Pirmas Projekto Formavimo Ciklas

Po `start` reiketu is karto padaryti pirma prasminga formavimo etapa.

Tipinis pirmas ciklas:
- apibrezti projekto tiksla
- susitarti del stacko
- sukurti pradine katalogu struktura
- aprasyti pirma etapa
- suformuoti backloga
- identifikuoti pradines rizikas

Tuo metu agentas turetu atnaujinti:
- `.claude/SNAPSHOT.md`
- `.claude/BACKLOG.md`
- `.claude/ROADMAP.md`
- `.claude/ARCHITECTURE.md`
- `.claude/DECISIONS.md`
- `.claude/RISKS.md`

## Ka Turetu Apimti Techninis Paruosimas

Teisingas techninis paruosimas turi atsakyti i siuos klausimus:

### 1. Koks stackas?

Pvz.:
- Python
- Node.js
- React
- Next.js
- PostgreSQL
- Docker

### 2. Kokia katalogu struktura?

Pvz.:

```text
src/
tests/
docs/
scripts/
```

### 3. Kaip paleidziamas projektas?

Turi buti aisku:
- kaip startuoti development rezimu
- kaip leisti testus
- kaip buildinti
- kaip vykdyti svarbiausius skriptus

### 4. Kur laikoma projekto eiga?

Tai turi buti aisku nuo pirmos dienos:
- `SNAPSHOT.md` = dabartine bukle
- `BACKLOG.md` = ka daryti toliau
- `ROADMAP.md` = etapai
- `ARCHITECTURE.md` = kaip sudeta sistema
- `DECISIONS.md` = ka nusprendem ir kodel
- `RISKS.md` = kas gali sutrukdyti

## Kodel Frameworka Geriau Deti Po Bazinio Projekto

Tai rekomenduojamas variantas del keliu priezasciu:

- frameworkas geriau supranta projekto struktura
- state failai sugeneruojami tikslesni
- architekturos santrauka buna prasmingesne
- lengviau iskart atskirti business code nuo framework failu

## Kada Galima Daryti Atvirksciai

Kartais galima pirma ideti frameworka, o po to kurti projekta.

Tai tinka, jei:
- projektas kuriamas nuo balto lapo
- nori, kad agentas kartu su tavimi formuotu struktura nuo pirmos minutes
- nori iskart naudoti frameworka kaip projekto vedimo sistema

Bet net ir tokiu atveju po frameworko idejimo verta kuo greiciau sukurti:
- `README.md`
- `.gitignore`
- pradine `src/` struktura
- pasirinkto stacko bazinius failus

## Kas Turi Atsirasti Po Teisingo Paleidimo

Po gero starto projekto busena turetu atrodyti mazdaug taip:

```text
Projektas/
  AGENTS.md
  CLAUDE.md
  FRAMEWORK_GUIDE.md
  FRAMEWORK_GUIDE_LT.md
  PROJECT_STARTUP_LT.md
  .claude/
    SNAPSHOT.md
    BACKLOG.md
    ROADMAP.md
    ARCHITECTURE.md
    DECISIONS.md
    RISKS.md
```

Ir jau turetu buti:
- aiskus aktyvus fokusas
- pradinis backlogas
- bent grubus roadmap
- pradine architekturos schema
- pradinis sprendimu zurnalas
- pradinis riziku sarasas
- pradinis `docs/` dokumentu komplektas

Profesionali pilna auksto lygio struktura atrodytu taip:

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
    SNAPSHOT.md
    BACKLOG.md
    ROADMAP.md
    ARCHITECTURE.md
    DECISIONS.md
    RISKS.md
    IDEAS.md
  .codex/
  docs/
    PRODUCT.md
    ARCHITECTURE_NOTES.md
    AI_CONTEXT.md
  src/
  security/
```

## Rekomenduojamas Pirmas Pokalbio Promptas

Po `start` labai geras pirmas nurodymas agentui butu toks:

```text
Isanalizuok projekta, pasiulyk pradine architektura, sukurk pirmo etapo plana, uzpildyk SNAPSHOT, BACKLOG, ROADMAP, ARCHITECTURE, DECISIONS ir RISKS failus.
```

Toks promptas iskart perjungia darba i tvarkinga rezima.

## Ko Nereikia Daryti Pradzioje

- nepalikti tuscios projekto saknies be jokio techninio karkaso
- nepradeti ilgo vystymo neinicijavus `git`
- nelaikyti viso plano tik pokalbio istorijoje
- nepalikti neaprasytu techniniu sprendimu
- neatidelioti state failu iki veliau

## Teisinga Logika Vienu Sakiniu

Pirma susikuri projekto pagrinda, tada idedi frameworka, po to paleidi `start`, o toliau agentas jau padeda ne tik programuoti, bet ir tvarkingai vesti visa projekto eiga.
