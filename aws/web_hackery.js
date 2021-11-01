// Clicks next in the secrets manager UI a certain number of times.
function clickNextSecretPage(num){
    if(!num) return;
    document.querySelector('.awsui-icon.awsui-icon-size-normal.awsui-icon-variant-normal path[d="M4 1l7 7-7 7"]')?.parentElement?.parentElement?.click();
    setTimeout(() => clickBollocks(num-1), 0);
}