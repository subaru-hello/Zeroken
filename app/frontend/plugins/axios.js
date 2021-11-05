import axios from 'axios';

let csrf_token = document.getElementsByName('csrf-token')[0].content;
const axiosInstance = axios.create({
  baseURL: '/api/v1',
  headers: { 'X-CSRF-TOKEN': csrf_token },
});

export default axiosInstance;
