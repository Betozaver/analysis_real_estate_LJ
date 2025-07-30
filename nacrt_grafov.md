-------1. Time-Series Line Chart
What it shows: Trends over time.

Example: Plot Year of Sale on the X-axis and Average Price per m²_bruto on the Y-axis.

Why: Reveals market cycles (bubbles, slowdowns) and lets you annotate policy or macro events.

--------2. Clustered Bar Chart by Municipalit-y
What it shows: Geographic price differences.

Example: Cadastral Municipality on the Y-axis, Average Price per m²_bruto on the X, with bars colored by New Build (True/False).

Why: Quickly spot which neighborhoods command premiums, and whether new developments drive up prices.

3. Filled Map (Choropleth)
What it shows: Spatial distribution of prices.

Example: Use the Shape Map or ArcGIS Map visual, fill each municipality with color based on Average Price per m²_bruto.

Why: A picture of “hot” vs “cold” areas in Ljubljana at a glance.

--------4. Scatter with Size & Color
What it shows: Relationship between size, age, and price.

Example:

X-axis: m2_neto (living area)

Y-axis: Price per m²_bruto

Size: Price (or m2_bruto)

Color: Year of Build or New Build

Why: See whether larger or newer homes really fetch more per m², and spot outliers.

5. Box-and-Whisker (or Violin) Plot
(Requires custom visual from AppSource)
What it shows: Distribution & outliers by category.

Example: Price per m²_bruto distributions for each how many rooms bucket.

Why: Compare variability—e.g., are 1-bed flats more volatile in price than 3-beds?
---comment: naredi v VS CODE


------------6. Histogram / Density Plot
What it shows: Frequency distribution.

Example: Histogram of Price per m²_bruto (or m2_bruto) with bins (e.g. €500/m² increments).

Why: Understand the bulk of the market: mid-range vs luxury vs bargain.

---------7. Decomposition Tree
What it shows: Drill-down drivers of price.

Example:

Root: Overall Avg Price per m²_bruto

Branches: first split by Cadastral Municipality, then by New Build or Year of Build, then by Rooms.

Why: Uncover the single biggest factor (location vs newness vs size) in price differences.

------8. Ribbon or Stacked Area Chart
What it shows: Market share evolution.

Example:

X-axis: Year of Sale
--
Y-axis: Count of sales

Legend: Cadastral Municipality (top 5) or New Build vs Resale

Why: See whether new builds are taking over the market, or which neighborhoods are growing in volume.

-------------9. Waterfall Chart NOT WORTH IT::::::
What it shows: Component‐wise build-up of price changes.

Example: Show stepwise change in Avg Price per m² from 2014 → 2024, broken out by the contribution of New Build share vs Resale share.

Why: Quantify how much of the overall price increase is due to more new projects vs underlying price inflation.

10. KPI Cards + Trend Arrows  ---- težka. probaj znova
What it shows: High-level metrics.

Examples:

Total Transactions (2014–2024)

Avg Price per m² (last year) with YoY % change

Median Year of Build (to show age of inventory)

Why: At-a-glance summary for dashboards or exec-reports.

Bonus: Correlation Matrix Heatmap
If you install a custom “Correlation Chart” visual, you can plot correlations between Price, m2_neto, m2_bruto, Rooms, and Year of Build—great for a quick multivariate sanity check.

Tip:
Use bookmarks and buttons to toggle between “New Build” vs “Resale,” or between “Apartment” vs “House,” so end-users can slice and dice without cluttering one page with a dozen visuals.