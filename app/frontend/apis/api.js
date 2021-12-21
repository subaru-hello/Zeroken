import axios from '../plugins/axios';
export default function fetchAlcohol(someAction) {
  axios.get('/alcohols').then((alcoholResponse) => {
    someAction(alcoholResponse);
  });
}
