{
  fetchFromGitHub,
  buildDotnetModule,
  dotnetCorePackages,
  lib,
}:

buildDotnetModule rec {
  pname = "WaveTracker";
  version = "47a11b10a9216509f7b065c2952f35d2a8e8cec1";

  src = fetchFromGitHub {
    owner = "Speykious";
    repo = pname;
    rev = "${version}";
    sha256 = "sha256-8OMsduTDW1uEg4rzSsQEKGSYMNQSkFCqASBufGcrm/A=";
  };

  projectFile = "WaveTracker.sln";

  executables = "WaveTracker";

  dotnet-sdk = dotnetCorePackages.sdk_8_0;
  dotnet-runtime = dotnetCorePackages.runtime_8_0;

  nugetDeps = ./deps.nix;

  meta = with lib; {
    homepage = "some_homepage";
    description = "some_description";
    license = licenses.mit;
  };
}
