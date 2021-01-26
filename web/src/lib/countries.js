import { countries } from 'countries-list';

export const countriesWithCode = Object
  .entries(countries)
  .map((struct) => ({ ...struct[1], code: struct[0] }));

export const sortedCountriesWithCode = countriesWithCode
  .sort((a, b) => (a.name.localeCompare(b.name)));
