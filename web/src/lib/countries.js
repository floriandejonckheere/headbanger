import { countries } from 'countries-list';

const countriesWithCode = Object
  .entries(countries)
  .map((struct) => ({ ...struct[1], code: struct[0] }));

const sortedCountriesWithCode = countriesWithCode
  .sort((a, b) => (a.name.localeCompare(b.name)));

export default {
  countriesWithCode,
  sortedCountriesWithCode,
};
