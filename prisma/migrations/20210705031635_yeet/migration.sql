-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'TEACHER', 'STUDENT');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('M', 'F');

-- CreateEnum
CREATE TYPE "SessionType" AS ENUM ('Murojaah', 'Setoran');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "code" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Teacher" (
    "code" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "gender" "Gender" NOT NULL,
    "birthPlace" TEXT NOT NULL,
    "birthDate" TIMESTAMP(3) NOT NULL,

    PRIMARY KEY ("code")
);

-- CreateTable
CREATE TABLE "TahfizhGroup" (
    "id" SERIAL NOT NULL,
    "teacherCode" INTEGER NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Student" (
    "nit" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "gender" "Gender" NOT NULL,
    "birthPlace" TEXT NOT NULL,
    "birthDate" TIMESTAMP(3) NOT NULL,
    "tahunMasuk" INTEGER NOT NULL,
    "tahunLulus" INTEGER NOT NULL,
    "tahfizhGroupId" INTEGER NOT NULL,

    PRIMARY KEY ("nit")
);

-- CreateTable
CREATE TABLE "Session" (
    "id" SERIAL NOT NULL,
    "waktuMulai" TIMESTAMP(3) NOT NULL,
    "waktuSelesai" TIMESTAMP(3) NOT NULL,
    "juz" INTEGER NOT NULL,
    "halaman" INTEGER NOT NULL,
    "awalSetoran" TEXT NOT NULL,
    "akhirSetoran" TEXT NOT NULL,
    "tajwid" INTEGER NOT NULL,
    "kelancaran" INTEGER NOT NULL,
    "makhrojSifat" INTEGER NOT NULL,
    "teacherCode" INTEGER NOT NULL,
    "studentNit" TEXT NOT NULL,
    "type" "SessionType" NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Alquran" (
    "id" SERIAL NOT NULL,
    "juz" INTEGER NOT NULL,
    "halaman" INTEGER NOT NULL,
    "surah" TEXT NOT NULL,
    "awalAyatHal" TEXT NOT NULL,
    "akhirAyatHal" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User.code_unique" ON "User"("code");

-- CreateIndex
CREATE UNIQUE INDEX "Teacher.email_unique" ON "Teacher"("email");

-- AddForeignKey
ALTER TABLE "TahfizhGroup" ADD FOREIGN KEY ("teacherCode") REFERENCES "Teacher"("code") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Student" ADD FOREIGN KEY ("tahfizhGroupId") REFERENCES "TahfizhGroup"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD FOREIGN KEY ("teacherCode") REFERENCES "Teacher"("code") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD FOREIGN KEY ("studentNit") REFERENCES "Student"("nit") ON DELETE CASCADE ON UPDATE CASCADE;
