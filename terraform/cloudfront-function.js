// CloudFront function to handle SPA routing
// Rewrite requests for non-existent files to index.html
function handler(event) {
  var request = event.request;
  var uri = request.uri;

  // If the request is for a file with an extension, let it through
  if (uri.includes('.')) {
    return request;
  }

  // If the request is for a directory without trailing slash, add it
  if (!uri.endsWith('/')) {
    request.uri += '/';
  }

  // For all other requests (directories, root, etc), rewrite to index.html
  if (!uri.includes('.html')) {
    request.uri = '/index.html';
  }

  return request;
}
